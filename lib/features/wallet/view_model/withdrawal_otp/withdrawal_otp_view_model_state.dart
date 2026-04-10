abstract class WithdrawalOtpState {}

class WithdrawalOtpInitial extends WithdrawalOtpState {}

class WithdrawalOtpLoading extends WithdrawalOtpState {}

class WithdrawalOtpSent extends WithdrawalOtpState {
  final String email;

  WithdrawalOtpSent(this.email);
}

class WithdrawalOtpVerified extends WithdrawalOtpState {
  final String email;
  final String token;

  WithdrawalOtpVerified({required this.email, required this.token});
}

class WithdrawalOtpConfirmed extends WithdrawalOtpState {}

class WithdrawalOtpError extends WithdrawalOtpState {
  final String message;

  WithdrawalOtpError(this.message);
}
