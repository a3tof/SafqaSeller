import 'package:flutter/material.dart';
import 'package:safqaseller/features/splash/view/widgets/splash_screen_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static const routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SplashScreenBody());
  }
}
