import 'package:flutter/material.dart';
import 'package:safqaseller/features/splash/view/splash_screen_view.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  static const routeName = 'tablet';

  @override
  Widget build(BuildContext context) {
    // The main.dart builder already constrains and centres the content to
    // _contentMaxWidth on wide screens, so no extra wrapping is needed here.
    return const SplashView();
  }
}
