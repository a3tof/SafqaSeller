import 'package:flutter/material.dart';
import 'package:safqaseller/features/splash/view/splash_screen_view.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  static const routeName = 'desktop';

  @override
  Widget build(BuildContext context) {
    // The main.dart builder already constrains and centres the content to
    // _contentMaxWidth on wide screens, so no extra wrapping is needed here.
    return const SplashView();
  }
}
