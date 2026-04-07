import 'dart:convert';
import 'dart:typed_data';

class ProfileModel {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  /// Raw base64-encoded image string returned by the API.
  final String? storeLogo;

  ProfileModel({
    this.fullName,
    this.email,
    this.phoneNumber,
    this.storeLogo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: (json['fullName'] ?? json['FullName'] ??
              json['name'] ?? json['Name'] ??
              json['storeName'] ?? json['StoreName']) as String?,
      email: (json['email'] ?? json['Email']) as String?,
      phoneNumber: (json['phoneNumber'] ?? json['PhoneNumber'] ??
              json['phone'] ?? json['Phone']) as String?,
      storeLogo: (json['storeLogo'] ?? json['StoreLogo'] ??
              json['logo'] ?? json['Logo'] ??
              json['profileImage'] ?? json['ProfileImage'] ??
              json['image'] ?? json['Image']) as String?,
    );
  }

  /// Decodes the base64 logo into raw bytes for `Image.memory`.
  Uint8List? get logoBytes {
    if (storeLogo == null || storeLogo!.isEmpty) return null;
    try {
      return base64Decode(storeLogo!);
    } catch (_) {
      return null;
    }
  }
}
