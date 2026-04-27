import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/utils/app_text_styles.dart';

import 'package:safqaseller/generated/l10n.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.controller,
  });

  final String hintText;
  final TextInputType textInputType;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      obscureText: obscureText,
      onSaved: onSaved,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).fieldRequired;
            }
            return null;
          },
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyles.bold13(context).copyWith(color: theme.hintColor),
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,
        errorMaxLines: 3,
        border: buildBorder(theme),
        enabledBorder: buildBorder(theme),
        focusedBorder: buildBorder(theme),
        errorBorder: buildBorder(theme, color: theme.colorScheme.error),
        focusedErrorBorder: buildBorder(theme, color: theme.colorScheme.error),
      ),
    );
  }

  OutlineInputBorder buildBorder(ThemeData theme, {Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(
        width: 1,
        color: color ?? theme.colorScheme.outline,
      ),
    );
  }
}
