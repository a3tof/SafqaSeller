// Request models

class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => {'email': email};
}

class VerifyOtpRequestModel {
  final String email;
  final String code;

  const VerifyOtpRequestModel({required this.email, required this.code});

  Map<String, dynamic> toJson() => {'email': email, 'code': code};
}

class ResetPasswordRequestModel {
  final String email;
  final String token;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.email,
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'token': token,
    'newPassword': newPassword,
  };
}

// Response models

class MessageResponseModel {
  final bool isSuccess;
  final String? message;

  const MessageResponseModel({required this.isSuccess, this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      isSuccess: json['IsSuccess'] ?? json['isSuccess'] ?? false,
      message: json['Message'] ?? json['message'],
    );
  }
}

class VerifyOtpResponseModel {
  final bool isSuccess;
  final String? message;
  final String? token;

  const VerifyOtpResponseModel({
    required this.isSuccess,
    this.message,
    this.token,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponseModel(
      isSuccess: json['IsSuccess'] ?? json['isSuccess'] ?? false,
      message: json['Message'] ?? json['message'],
      token: json['Token'] ?? json['token'],
    );
  }
}
