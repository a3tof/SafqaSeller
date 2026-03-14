import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/widgets/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    required this.hintText,
    this.validator,
    this.enabled = true,
  });

  final void Function(String?)? onSaved;
  final String hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      enabled: widget.enabled,
      obscureText: obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      hintText: widget.hintText,
      textInputType: TextInputType.visiblePassword,
      suffixIcon: InkWell(
        onTap: () {
          obscureText = !obscureText;
          setState(() {});
        },
        child: obscureText
            ? Icon(Icons.remove_red_eye, color: Color(0xFFC9CECF), size: 24.sp)
            : Icon(Icons.visibility_off, color: Color(0xFFC9CECF), size: 24.sp),
      ),
    );
  }
}
