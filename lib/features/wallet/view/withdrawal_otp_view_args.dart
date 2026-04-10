class WithdrawalOtpArgs {
  final double amount;
  final int cardId;
  final String email;

  const WithdrawalOtpArgs({
    required this.amount,
    required this.cardId,
    required this.email,
  });
}
