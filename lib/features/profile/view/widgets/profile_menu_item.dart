import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailingIcon = Icons.chevron_right,
    this.trailing,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final IconData trailingIcon;
  final Widget? trailing;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyles.regular14(context).copyWith(
                  color: textColor ?? Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            trailing ??
                Icon(
                  trailingIcon,
                  color: iconColor ?? Theme.of(context).colorScheme.primary,
                  size: 22.sp,
                ),
          ],
        ),
      ),
    );
  }
}
