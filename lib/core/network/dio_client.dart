import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:safqaseller/core/config/app_config.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';

class DioHelper {
  final Dio dio;
  final CacheHelper _cacheHelper;

  DioHelper({required CacheHelper cacheHelper})
      : _cacheHelper = cacheHelper,
        dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
            receiveDataWhenStatusError: true,
            // Accept every status code — repositories decide what is success/failure.
            validateStatus: (_) => true,
            headers: {
              'x-api-key': AppConfig.apiKey,
            },
          ),
        ) {
    // ── Header injection + token refresh ────────────────────────────────────
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final deviceId = _cacheHelper.getData(key: CacheKeys.deviceId);
          if (deviceId != null) {
            options.headers['DeviceId'] = deviceId;
          }
          // Skip refresh logic on the refresh call itself to prevent loops.
          if (options.extra['requiresAuth'] == true &&
              options.extra['_refreshing'] != true) {
            final token = await _getValidToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          handler.next(options);
        },
      ),
    );

    // ── Request / response logger (debug builds only) ───────────────────────
    if (kDebugMode) {
      dio.interceptors.add(_ApiLogger());
    }
  }

  // ── Token expiry + refresh ───────────────────────────────────────────────

  /// Returns a valid token, refreshing it first if it is older than 5 hours.
  Future<String?> _getValidToken() async {
    final token = _cacheHelper.getData(key: CacheKeys.token) as String?;
    if (token == null || token.isEmpty) return null;

    final tokenTimeStr =
        _cacheHelper.getData(key: CacheKeys.tokenTime) as String?;
    if (tokenTimeStr != null) {
      final tokenTime = DateTime.tryParse(tokenTimeStr);
      if (tokenTime != null &&
          DateTime.now().difference(tokenTime).inHours >= 5) {
        return await _refreshAccessToken(token);
      }
    }
    return token;
  }

  /// Calls Auth/refresh-token with the stored refresh token payload.
  /// Returns the new token on success, or falls back to the expired token.
  Future<String?> _refreshAccessToken(String expiredToken) async {
    try {
      final storedRefresh =
          _cacheHelper.getData(key: CacheKeys.refreshToken) as String?;
      final tokenToSend =
          (storedRefresh != null && storedRefresh.isNotEmpty)
              ? storedRefresh
              : expiredToken;

      final response = await dio.post<dynamic>(
        'Auth/refresh-token',
        data: {'refreshToken': tokenToSend},
        options: Options(
          extra: {'_refreshing': true},
          contentType: 'application/json',
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final body = _decodeIfString(response.data);
        if (body is Map) {
          final newToken = (body['Token'] ?? body['token']) as String?;
          if (newToken != null && newToken.isNotEmpty) {
            await _cacheHelper.saveData(
                key: CacheKeys.token, value: newToken);
            await _cacheHelper.saveData(
              key: CacheKeys.tokenTime,
              value: DateTime.now().toIso8601String(),
            );
            final newRefresh =
                (body['RefreshToken'] ?? body['refreshToken']) as String?;
            if (newRefresh != null) {
              await _cacheHelper.saveData(
                  key: CacheKeys.refreshToken, value: newRefresh);
            }
            return newToken;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Token refresh failed: $e');
    }
    // Fall back — let the server decide what to do with the expired token.
    return expiredToken;
  }

  Future<Response<dynamic>> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) async {
    return dio.post<dynamic>(
      endPoint,
      data: data,
      queryParameters: queryParams,
      options: Options(
        contentType: Headers.jsonContentType,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
  }

  Future<Response<dynamic>> postNoBody({
    required String endPoint,
    bool requiresAuth = false,
  }) async {
    return dio.post<dynamic>(
      endPoint,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }

  Future<Response<dynamic>> getData({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) async {
    return dio.get<dynamic>(
      endPoint,
      queryParameters: queryParams,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }

  Future<Response<dynamic>> postFormData({
    required String endPoint,
    required FormData data,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) async {
    return dio.post<dynamic>(
      endPoint,
      data: data,
      queryParameters: queryParams,
      options: Options(
        extra: {'requiresAuth': requiresAuth},
      ),
    );
  }

  Future<Response<dynamic>> putData({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = false,
  }) async {
    return dio.put<dynamic>(
      endPoint,
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
  }

  Future<Response<dynamic>> deleteData({
    required String endPoint,
    bool requiresAuth = false,
  }) async {
    return dio.delete<dynamic>(
      endPoint,
      options: Options(extra: {'requiresAuth': requiresAuth}),
    );
  }

  Future<Response<dynamic>> deleteWithBody({
    required String endPoint,
    required Map<String, dynamic> data,
    bool requiresAuth = false,
  }) async {
    return dio.delete<dynamic>(
      endPoint,
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        extra: {'requiresAuth': requiresAuth},
      ),
    );
  }
}

// ── Logger interceptor ────────────────────────────────────────────────────────

class _ApiLogger extends Interceptor {
  static final _sep = '─' * 60;
  static const _indent = '  ';

  // Sensitive header keys whose values are masked in logs.
  static const _maskedHeaders = {'authorization', 'x-api-key'};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buf = StringBuffer();
    buf.writeln(_sep);
    buf.writeln('➤ REQUEST');
    buf.writeln('$_indent${options.method}  ${options.uri}');
    buf.writeln('$_indent headers:');
    options.headers.forEach((k, v) {
      final display = _maskedHeaders.contains(k.toLowerCase())
          ? _mask(v.toString())
          : v;
      buf.writeln('$_indent$_indent$k: $display');
    });
    if (options.data != null) {
      buf.writeln('$_indent body:');
      buf.writeln('$_indent$_indent${_prettyJson(options.data)}');
    }
    buf.write(_sep);
    debugPrint(buf.toString());
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final buf = StringBuffer();
    final ok = _isSuccess(response.statusCode);
    buf.writeln(_sep);
    buf.writeln('${ok ? '✔' : '✘'} RESPONSE  [${response.statusCode}]');
    buf.writeln(
      '$_indent${response.requestOptions.method}  ${response.requestOptions.uri}',
    );
    buf.writeln('$_indent body:');
    buf.writeln('$_indent$_indent${_prettyJson(response.data)}');
    buf.write(_sep);
    debugPrint(buf.toString());
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buf = StringBuffer();
    buf.writeln(_sep);
    buf.writeln('✘ ERROR  [${err.response?.statusCode ?? err.type.name}]');
    buf.writeln(
      '$_indent${err.requestOptions.method}  ${err.requestOptions.uri}',
    );
    buf.writeln('$_indent message: ${err.message}');
    if (err.response?.data != null) {
      buf.writeln('$_indent body:');
      buf.writeln('$_indent$_indent${_prettyJson(err.response?.data)}');
    }
    buf.write(_sep);
    debugPrint(buf.toString());
    handler.next(err);
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  bool _isSuccess(int? code) => code != null && code >= 200 && code < 300;

  /// Shows first 6 chars + asterisks so the key is identifiable but not leaked.
  String _mask(String value) {
    if (value.length <= 6) return '***';
    return '${value.substring(0, 6)}${'*' * (value.length - 6)}';
  }

  String _prettyJson(dynamic data) {
    if (data == null) return 'null';
    try {
      final encoder = const JsonEncoder.withIndent('    ');
      if (data is String) {
        final decoded = jsonDecode(data);
        return encoder.convert(decoded);
      }
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }
}

// ── Response helper used by all repositories ─────────────────────────────────

/// Extracts a human-readable error message from any response body.
/// Never throws.
String extractResponseError(dynamic data, int? statusCode) {
  final body = _decodeIfString(data);

  if (body is Map) {
    final msg = _str(body['message']) ??
        _str(body['Message']) ??
        _str(body['title']) ??
        _str(body['Title']);
    if (msg != null && msg.isNotEmpty) return msg;

    final errors = body['Errors'] ?? body['errors'];
    if (errors is Map && errors.isNotEmpty) {
      final firstErrorValue = errors.values.first;
      if (firstErrorValue is List && firstErrorValue.isNotEmpty) {
        return firstErrorValue.first?.toString() ?? 'Validation error';
      }
      return firstErrorValue.toString();
    }
    if (errors is List && errors.isNotEmpty) {
      return errors.first?.toString() ?? 'Unknown error';
    }
    if (errors is String && errors.isNotEmpty) return errors;
  }

  // Server returned a plain JSON array like ["Invalid OTP"] — take the first item.
  if (body is List && body.isNotEmpty) {
    final first = body.first;
    if (first is String && first.isNotEmpty) return first;
  }

  if (body is String && body.isNotEmpty) return body;

  return 'Server error (${statusCode ?? '?'})';
}

dynamic _decodeIfString(dynamic data) {
  if (data is String) {
    try {
      return jsonDecode(data);
    } catch (_) {
      return data;
    }
  }
  return data;
}

String? _str(dynamic v) => v is String ? v : null;
