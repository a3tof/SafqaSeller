import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/core/widgets/custom_app_bar.dart';
import 'package:safqaseller/core/widgets/password_field.dart';
import 'package:safqaseller/features/wallet/view/withdrawal_otp_view_args.dart';
import 'package:safqaseller/features/wallet/view_model/withdrawal_otp/withdrawal_otp_view_model.dart';
import 'package:safqaseller/features/wallet/view_model/withdrawal_otp/withdrawal_otp_view_model_state.dart';
import 'package:safqaseller/generated/l10n.dart';

class WithdrawalOtpViewBody extends StatefulWidget {
  const WithdrawalOtpViewBody({super.key, required this.args});

  final WithdrawalOtpArgs args;

  @override
  State<WithdrawalOtpViewBody> createState() => _WithdrawalOtpViewBodyState();
}

class _WithdrawalOtpViewBodyState extends State<WithdrawalOtpViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _verifiedToken;

  bool get _isPasswordStep => _verifiedToken != null && _verifiedToken!.isNotEmpty;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<WithdrawalOtpViewModel>().requestOtp(widget.args.email);
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_isPasswordStep) {
      context.read<WithdrawalOtpViewModel>().confirmAndWithdraw(
            email: widget.args.email,
            token: _verifiedToken ?? '',
            password: _passwordController.text.trim(),
            amount: widget.args.amount,
            cardId: widget.args.cardId,
          );
      return;
    }
    context.read<WithdrawalOtpViewModel>().verifyOtp(
          email: widget.args.email,
          code: _otpController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WithdrawalOtpViewModel, WithdrawalOtpState>(
      listener: (context, state) {
        if (state is WithdrawalOtpSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).otpSentToEmail),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is WithdrawalOtpVerified) {
          setState(() {
            _verifiedToken = state.token;
          });
        } else if (state is WithdrawalOtpConfirmed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).kWithdrawalSuccessfu),
              backgroundColor: const Color(0xFF7DD97B),
            ),
          );
          Navigator.pop(context, true);
        } else if (state is WithdrawalOtpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_friendlyError(context, state.message)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is WithdrawalOtpLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(
            context: context,
            title: _isPasswordStep
                ? S.of(context).confirmWithdrawal
                : S.of(context).verificationCode,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isPasswordStep
                              ? S.of(context).confirmWithdrawalDescription
                              : S.of(context).verifyWithdrawalDescription,
                          style: TextStyles.regular16(
                            context,
                          ).copyWith(color: const Color(0xFF4C4C4C), height: 1.5),
                        ),
                        SizedBox(height: 24.h),
                        if (_isPasswordStep)
                          PasswordField(
                            controller: _passwordController,
                            enabled: !isLoading,
                            hintText: S.of(context).currentPassword,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return S.of(context).fieldRequired;
                              }
                              return null;
                            },
                          )
                        else
                          TextFormField(
                            controller: _otpController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return S.of(context).fieldRequired;
                              }
                              if (value.trim().length < 4) {
                                return S.of(context).invalidOtp;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: S.of(context).verificationCode,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                            ),
                          ),
                        if (!_isPasswordStep) ...[
                          SizedBox(height: 16.h),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () => context
                                      .read<WithdrawalOtpViewModel>()
                                      .resendOtp(widget.args.email),
                              child: Text(S.of(context).resend),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 40.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54.h,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: 22.w,
                              height: 22.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              _isPasswordStep
                                  ? S.of(context).confirmWithdrawal
                                  : S.of(context).verify,
                              style: TextStyles.semiBold19(
                                context,
                              ).copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _friendlyError(BuildContext context, String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('expired') || lower.contains('exp')) {
      return S.of(context).otpExpired;
    }
    if (lower.contains('invalid') ||
        lower.contains('incorrect') ||
        lower.contains('wrong') ||
        lower.contains('not valid') ||
        lower.contains('otp')) {
      return S.of(context).invalidOtp;
    }
    return raw;
  }
}
