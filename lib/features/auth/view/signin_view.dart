import 'package:flutter/material.dart';
import 'package:safqaseller/features/auth/view/widgets/signin_view_body.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});
  static const routeName = 'signinView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SigninViewBody(),
    );
  }
}