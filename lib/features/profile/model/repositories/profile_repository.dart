import 'package:safqaseller/core/network/dio_client.dart';
import 'package:safqaseller/features/profile/model/models/profile_model.dart';

class ProfileRepository {
  final DioHelper dioHelper;

  ProfileRepository({required this.dioHelper});

  // GET /api/seller/business-account
  // Authorization: Bearer {token}
  Future<ProfileModel> getProfile() async {
    final response = await dioHelper.getData(
      endPoint: 'seller/business-account',
      requiresAuth: true,
    );

    final code = response.statusCode;
    if (code != null && (code < 200 || code > 299)) {
      throw Exception(extractResponseError(response.data, code));
    }

    final data = response.data;
    if (data is Map<String, dynamic>) {
      return ProfileModel.fromJson(data);
    }
    throw Exception('Unexpected profile response format');
  }
}
