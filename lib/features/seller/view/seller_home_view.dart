import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/auth/view_model/auth/auth_view_model.dart';
import 'package:safqaseller/features/auth/view_model/auth/auth_view_model_state.dart';
import 'package:safqaseller/features/home/view/home_screen_view.dart';
import 'package:safqaseller/features/seller/view_model/seller_view_model.dart';
import 'package:safqaseller/features/seller/view_model/seller_view_model_state.dart';

class SellerHomeView extends StatelessWidget {
  const SellerHomeView({super.key});
  static const String routeName = 'sellerHomeView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SellerViewModel>()..getSellerHome(),
      child: _SellerHomeBody(),
    );
  }
}

class _SellerHomeBody extends StatelessWidget {
  const _SellerHomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<SellerViewModel, SellerViewModelState>(
          builder: (context, state) {
            if (state is SellerLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            }

            if (state is SellerError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red.shade400,
                        size: 48.sp,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyles.regular16(context)
                            .copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7)),
                      ),
                      SizedBox(height: 24.h),
                      TextButton(
                        onPressed: () {
                          context.read<SellerViewModel>().getSellerHome();
                        },
                        child: Text(
                          'Retry',
                          style: TextStyles.semiBold16(context)
                              .copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is SellerHomeLoaded) {
              final data = state.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.h),
                  // Logo + Store Name header
                  Center(
                    child: Column(
                      children: [
                        _StoreLogo(logoBase64: data.storeLogo),
                        SizedBox(height: 12.h),
                        Text(
                          data.storeName,
                          style: TextStyles.bold22(context)
                              .copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Welcome content
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to your store!',
                          style: TextStyles.semiBold20(context)
                              .copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Your seller account is active. Start managing your auctions and products from here.',
                          style: TextStyles.regular14(context).copyWith(
                            color: Theme.of(context).hintColor,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreenView.routeName,
                                (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                            ),
                            child: Text(
                              'Go to Home',
                              style: TextStyles.semiBold16(context)
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // Logout hint
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: BlocBuilder<AuthViewModel, AuthViewModelState>(
                      builder: (context, authState) {
                        return Text(
                          authState is AuthAuthenticated
                              ? 'Logged in as: ${authState.role}'
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyles.regular12(context)
                              .copyWith(color: Theme.of(context).hintColor),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _StoreLogo extends StatelessWidget {
  const _StoreLogo({this.logoBase64});

  final String? logoBase64;

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (logoBase64 != null && logoBase64!.isNotEmpty) {
      try {
        final bytes = base64Decode(logoBase64!);
        child = ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: Image.memory(
            bytes,
            width: 80.w,
            height: 80.w,
            fit: BoxFit.cover,
          ),
        );
      } catch (_) {
        child = _defaultLogo(context);
      }
    } else {
      child = _defaultLogo(context);
    }

    return child;
  }

  Widget _defaultLogo(BuildContext context) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1.5,
        ),
      ),
      child: Icon(
        Icons.storefront_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 40.sp,
      ),
    );
  }
}
