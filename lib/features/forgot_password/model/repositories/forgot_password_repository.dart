import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/features/forgot_password/model/models/forgot_password_models.dart';

class ForgotPasswordRepository {
  final DioHelper dioHelper;

  ForgotPasswordRepository({required this.dioHelper});

  Future<MessageResponseModel> requestOtp(
    ForgotPasswordRequestModel model,
  ) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/request-ForgetPassword',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final result = _parse(r.data);
    if (!result.isSuccess) throw Exception(result.message ?? 'Request failed');
    return result;
  }

  Future<VerifyOtpResponseModel> verifyOtp(VerifyOtpRequestModel model) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/verify-ForgetPassword',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final result = _parseVerify(r.data);
    if (!result.isSuccess) {
      throw Exception(result.message ?? 'OTP verification failed');
    }
    return result;
  }

  Future<MessageResponseModel> resetPassword(
    ResetPasswordRequestModel model,
  ) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/reset-ForgetPassword',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final result = _parse(r.data);
    if (!result.isSuccess) {
      throw Exception(result.message ?? 'Password reset failed');
    }
    return result;
  }

  Future<MessageResponseModel> resendOtp(
    ForgotPasswordRequestModel model,
  ) async {
    final r = await dioHelper.postData(
      endPoint: 'Auth/resendOtp',
      data: model.toJson(),
    );
    _requireSuccess(r);
    final result = _parse(r.data);
    if (!result.isSuccess) throw Exception(result.message ?? 'Resend failed');
    return result;
  }

  Future<MessageResponseModel> signOutAll() async {
    final r = await dioHelper.postNoBody(
      endPoint: 'Auth/signout-all',
      requiresAuth: true,
    );
    _requireSuccess(r);
    return _parse(r.data);
  }

  void _requireSuccess(dynamic r) {
    final code = (r as dynamic).statusCode as int?;
    if (code != null && (code < 200 || code > 299)) {
      throw Exception(extractResponseError(r.data, code));
    }
  }

  MessageResponseModel _parse(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected response format');
    }
    return MessageResponseModel.fromJson(data);
  }

  VerifyOtpResponseModel _parseVerify(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected response format');
    }
    return VerifyOtpResponseModel.fromJson(data);
  }
}
