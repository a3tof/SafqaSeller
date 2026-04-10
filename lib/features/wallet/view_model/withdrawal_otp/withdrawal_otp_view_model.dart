import 'package:safqaseller/features/wallet/model/models/wallet_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/features/wallet/model/repositories/wallet_repository.dart';
import 'package:safqaseller/features/wallet/view_model/withdrawal_otp/withdrawal_otp_view_model_state.dart';

class WithdrawalOtpViewModel extends Cubit<WithdrawalOtpState> {
  final WalletRepository walletRepository;

  WithdrawalOtpViewModel(this.walletRepository) : super(WithdrawalOtpInitial());

  Future<void> requestOtp(String email) async {
    emit(WithdrawalOtpLoading());
    try {
      await walletRepository.requestWithdrawalOtp(email);
      emit(WithdrawalOtpSent(email));
    } catch (e) {
      emit(WithdrawalOtpError(_clean(e)));
    }
  }

  Future<void> resendOtp(String email) async {
    await requestOtp(email);
  }

  Future<void> verifyOtp({
    required String email,
    required String code,
  }) async {
    emit(WithdrawalOtpLoading());
    try {
      final response = await walletRepository.verifyWithdrawalOtp(email, code);
      emit(
        WithdrawalOtpVerified(
          email: email,
          token: response.token ?? '',
        ),
      );
    } catch (e) {
      emit(WithdrawalOtpError(_clean(e)));
    }
  }

  Future<void> confirmAndWithdraw({
    required String email,
    required String token,
    required String password,
    required double amount,
    required int cardId,
  }) async {
    emit(WithdrawalOtpLoading());
    try {
      await walletRepository.confirmWithdrawalReset(email, token, password);
      await walletRepository.withdraw(
        WithdrawalRequest(amount: amount, cardId: cardId),
      );
      emit(WithdrawalOtpConfirmed());
    } catch (e) {
      emit(WithdrawalOtpError(_clean(e)));
    }
  }

  String _clean(Object error) {
    String message = error.toString();
    if (message.startsWith('Exception: ')) {
      message = message.replaceFirst('Exception: ', '');
    }
    return message;
  }
}
