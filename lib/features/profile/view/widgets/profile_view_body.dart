import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/services/notification_service.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/core/utils/app_color.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';
import 'package:safqaseller/features/auth/view_model/logout/logout_view_model.dart';
import 'package:safqaseller/features/change_password/view/change_password_view.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_header_section.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_info_field.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_menu_item.dart';
import 'package:safqaseller/features/profile/view/widgets/profile_metrics_row.dart';
import 'package:safqaseller/features/history/view/history_view.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model.dart';
import 'package:safqaseller/features/profile/view_model/profile_view_model_state.dart';
import 'package:safqaseller/features/wallet/view/wallet_view.dart';
import 'package:safqaseller/main.dart';
import 'package:safqaseller/generated/l10n.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  late bool _notificationsEnabled;
  bool _updatingNotifications = false;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled =
        (getIt<CacheHelper>().getData(key: CacheKeys.notificationsEnabled)
            as bool?) ??
        false;
  }

  Future<void> _refreshProfile(BuildContext context) async {
    await context.read<ProfileViewModel>().fetchProfile(showLoadingState: true);
  }

  Future<void> _toggleNotifications(bool enabled) async {
    if (_updatingNotifications) {
      return;
    }

    setState(() => _updatingNotifications = true);

    final notificationService = getIt<NotificationService>();
    var nextValue = enabled;

    if (enabled) {
      final granted = await notificationService.requestPermissions();
      nextValue = granted;

      if (!granted && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Notification permission is required to enable alerts.',
            ),
          ),
        );
      }
    }

    await notificationService.setNotificationsEnabled(nextValue);

    if (!mounted) {
      return;
    }

    setState(() {
      _notificationsEnabled = nextValue;
      _updatingNotifications = false;
    });
  }

  Future<void> _changeLanguage({
    required BuildContext context,
    required Locale locale,
    required String cacheValue,
  }) async {
    Navigator.of(context).pop();
    await getIt<CacheHelper>().saveData(
      key: CacheKeys.language,
      value: cacheValue,
    );
    if (mounted) {
      SafqaSeller.of(this.context)?.setLocale(locale);
    }
  }

  Future<void> _showStyledDialog({
    required BuildContext context,
    required String title,
    required String message,
    required List<_ProfileDialogAction> actions,
    required Color titleColor,
  }) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyles.bold28(
                      context,
                    ).copyWith(color: titleColor),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyles.regular20(
                      context,
                    ).copyWith(color: const Color(0xFF6B7280), height: 1.4),
                  ),
                  SizedBox(height: 28.h),
                  Row(
                    children: [
                      for (var index = 0; index < actions.length; index++) ...[
                        Expanded(
                          child: SizedBox(
                            height: 48.h,
                            child: ElevatedButton(
                              onPressed: actions[index].onPressed,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: actions[index].backgroundColor,
                                foregroundColor: actions[index].foregroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                              ),
                              child: Text(
                                actions[index].label,
                                style: TextStyles.bold18(context).copyWith(
                                  color: actions[index].foregroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (index != actions.length - 1) SizedBox(width: 12.w),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) {
    return _showStyledDialog(
      context: context,
      title: '${S.of(context).kLogout}?',
      message: S.of(context).profileLogoutDialogMessage,
      titleColor: Colors.red,
      actions: [
        _ProfileDialogAction(
          label: S.of(context).kLogout,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
            context.read<LogoutViewModel>().logout();
          },
        ),
        _ProfileDialogAction(
          label: S.of(context).notificationsCancel,
          backgroundColor: const Color(0xFFDCE9FB),
          foregroundColor: AppColors.primaryColor,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Future<void> _showLanguageDialog(BuildContext context) {
    final selectedLanguage =
        Localizations.localeOf(context).languageCode == 'en'
        ? 'english'
        : 'arabic';
    return showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).kChangeLanguage,
                    textAlign: TextAlign.center,
                    style: TextStyles.bold28(
                      context,
                    ).copyWith(color: AppColors.primaryColor),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    S.of(context).profileLanguageDialogMessage,
                    textAlign: TextAlign.center,
                    style: TextStyles.regular20(
                      context,
                    ).copyWith(color: const Color(0xFF6B7280), height: 1.4),
                  ),
                  SizedBox(height: 24.h),
                  _LanguageOptionTile(
                    label: S.of(context).kEnglish,
                    value: 'english',
                    groupValue: selectedLanguage,
                    onTap: () => _changeLanguage(
                      context: dialogContext,
                      locale: const Locale('en'),
                      cacheValue: 'english',
                    ),
                  ),
                  SizedBox(height: 12.h),
                  _LanguageOptionTile(
                    label: S.of(context).kArabic,
                    value: 'arabic',
                    groupValue: selectedLanguage,
                    onTap: () => _changeLanguage(
                      context: dialogContext,
                      locale: const Locale('ar'),
                      cacheValue: 'arabic',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProfileViewModel, ProfileViewModelState>(
        builder: (context, profileState) {
          final fullName = profileState is ProfileLoaded
              ? (profileState.fullName ?? '—')
              : '—';
          final email = profileState is ProfileLoaded
              ? (profileState.email ?? '—')
              : '—';
          final phoneNumber = profileState is ProfileLoaded
              ? (profileState.phoneNumber ?? '—')
              : '—';
          final logoBytes = profileState is ProfileLoaded
              ? profileState.logoBytes
              : null;
          final rating = profileState is ProfileLoaded
              ? (profileState.rating ?? '0')
              : '0';
          final followersCount = profileState is ProfileLoaded
              ? (profileState.followersCount ?? '0')
              : '0';
          final auctionsCount = profileState is ProfileLoaded
              ? (profileState.auctionsCount ?? '0')
              : '0';
          final activePlanId = profileState is ProfileLoaded
              ? profileState.activePlanId
              : null;
          final cityLabel = profileState is ProfileLoaded
              ? ((profileState.cityName?.trim().isNotEmpty ?? false)
                    ? profileState.cityName!
                    : (profileState.countryName?.trim().isNotEmpty ?? false)
                    ? profileState.countryName!
                    : S.of(context).kCairoEgypt)
              : S.of(context).kCairoEgypt;

          return RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () => _refreshProfile(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  // ── Profile Header (Avatar + Buttons) ──
                  ProfileHeaderSection(
                    logoBytes: logoBytes,
                    activePlanId: activePlanId,
                  ),
                  SizedBox(height: 20.h),

                  // ── Metrics Row (Rating, Users, Deliveries) ──
                  ProfileMetricsRow(
                    rating: rating,
                    followersCount: followersCount,
                    auctionsCount: auctionsCount,
                  ),
                  SizedBox(height: 24.h),

                  // ── User Info Fields — data from GET Auth/profile ──
                  ProfileInfoField(icon: Icons.person_outline, value: fullName),
                  SizedBox(height: 12.h),
                  ProfileInfoField(icon: Icons.email_outlined, value: email),
                  SizedBox(height: 12.h),
                  ProfileInfoField(
                    icon: Icons.phone_outlined,
                    value: phoneNumber,
                  ),
                  SizedBox(height: 12.h),

                  // ── Navigation Menu Items ──
                  ProfileMenuItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: S.of(context).kWallet,
                    onTap: () {
                      Navigator.pushNamed(context, WalletView.routeName);
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.location_on_outlined,
                    label: cityLabel,
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.access_time,
                    label: S.of(context).kHistory,
                    onTap: () {
                      Navigator.pushNamed(context, HistoryView.routeName);
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.bar_chart_outlined,
                    label: S.of(context).kStatistics,
                    onTap: () {},
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.lock_outline_rounded,
                    label: S.of(context).kChangePassword,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ChangePasswordView.routeName,
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.language_outlined,
                    label: S.of(context).kChangeLanguage,
                    onTap: () {
                      _showLanguageDialog(context);
                    },
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    trailing: IgnorePointer(
                      child: Switch.adaptive(
                        value: _notificationsEnabled,
                        onChanged: (_) {},
                        activeTrackColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    onTap: () => _toggleNotifications(!_notificationsEnabled),
                  ),
                  SizedBox(height: 12.h),
                  ProfileMenuItem(
                    icon: Icons.logout_rounded,
                    label: S.of(context).kLogout,
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProfileDialogAction {
  const _ProfileDialogAction({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onTap,
  });

  final String label;
  final String value;
  final String groupValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCE9FB) : Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyles.semiBold16(
                  context,
                ).copyWith(color: AppColors.primaryColor),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: AppColors.primaryColor,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
