import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/features/wallet/view/widgets/withdrawal_otp_view_body.dart';
import 'package:safqaseller/features/wallet/view/withdrawal_otp_view_args.dart';
import 'package:safqaseller/features/wallet/view_model/withdrawal_otp/withdrawal_otp_view_model.dart';

class WithdrawalOtpView extends StatelessWidget {
  const WithdrawalOtpView({super.key, required this.args});

  static const String routeName = 'withdrawalOtp';

  final WithdrawalOtpArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WithdrawalOtpViewModel>(),
      child: WithdrawalOtpViewBody(args: args),
    );
  }
}
