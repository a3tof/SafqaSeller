import 'package:dio/dio.dart';
import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/features/seller/model/models/api_response.dart';
import 'package:safqaseller/features/seller/model/models/create_seller_response.dart';
import 'package:safqaseller/features/seller/model/models/seller_home_response.dart';

class SellerRepository {
  final DioHelper dioHelper;

  SellerRepository({required this.dioHelper});

  // ── Create Seller ─────────────────────────────────────────────────────────
  // POST /api/seller/CreateSeller
  // Content-Type: multipart/form-data
  // Authorization: Bearer {token}

  Future<CreateSellerResponse> createSeller({
    required String storeName,
    required String phoneNumber,
    required int cityId,
    required int businessType,
    required String description,
    MultipartFile? logo,
  }) async {
    final formData = FormData.fromMap({
      'StoreName': storeName,
      'PhoneNumber': phoneNumber,
      'CityId': cityId,
      'BusinessType': businessType,
      'Description': description,
      'Logo': ?logo,
    });

    final response = await dioHelper.postFormData(
      endPoint: 'seller/CreateSeller',
      data: formData,
      requiresAuth: true,
    );

    _requireSuccess(response);
    return CreateSellerResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  // ── Personal Verification ─────────────────────────────────────────────────
  // POST /api/seller/{sellerId}/personal-verification
  // Content-Type: multipart/form-data
  // Authorization: Bearer {token}

  Future<ApiResponse> personalVerification({
    required MultipartFile nationalIdFront,
    required MultipartFile nationalIdBack,
    required MultipartFile selfieWithId,
  }) async {
    final formData = FormData.fromMap({
      'NationalIdFront': nationalIdFront,
      'NationalIdBack': nationalIdBack,
      'SelfieWithId': selfieWithId,
    });

    final response = await dioHelper.postFormData(
      endPoint: 'seller/personal-verification',
      data: formData,
      requiresAuth: true,
    );

    _requireSuccess(response);
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }

  // ── Business Verification ─────────────────────────────────────────────────
  // POST /api/seller/{sellerId}/business-verification
  // Content-Type: multipart/form-data
  // Authorization: Bearer {token}

  Future<ApiResponse> businessVerification({
    required int sellerId,
    required MultipartFile commercialRegister,
    required MultipartFile taxId,
    required MultipartFile ownerNationalIdFront,
    required MultipartFile ownerNationalIdBack,
    required String bankName,
    required String accountName,
    required String iban,
    String? localAccountNumber,
    int? instaPayNumber,
  }) async {
    final formData = FormData.fromMap({
      'CommercialRegister': commercialRegister,
      'TaxId': taxId,
      'OwnerNationalIdFront': ownerNationalIdFront,
      'OwnerNationalIdBack': ownerNationalIdBack,
      'BankName': bankName,
      'AccountName': accountName,
      'IBAN': iban,
      if (localAccountNumber != null && localAccountNumber.isNotEmpty)
        'LocalAccountNumber': localAccountNumber,
      'instaPayNumber': ?instaPayNumber,
    });

    final response = await dioHelper.postFormData(
      endPoint: 'seller/$sellerId/business-verification',
      data: formData,
      requiresAuth: true,
    );

    _requireSuccess(response);
    return ApiResponse.fromJson(response.data as Map<String, dynamic>);
  }

  // ── Seller Home ───────────────────────────────────────────────────────────
  // GET /api/seller/Home
  // Authorization: Bearer {token}

  Future<SellerHomeResponse> getSellerHome() async {
    final response = await dioHelper.getData(
      endPoint: 'seller/Home',
      requiresAuth: true,
    );

    _requireSuccess(response);
    return SellerHomeResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _requireSuccess(Response<dynamic> response) {
    final code = response.statusCode;
    if (code != null && (code < 200 || code > 299)) {
      throw Exception(extractResponseError(response.data, code));
    }
  }
}
