import 'package:flutter/material.dart';
import 'package:safqaseller/features/adaptive_layout/view/adaptive_layout.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/desktop_layout.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/mobile_layout.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/tablet_layout.dart';
class AdaptiveLayoutView extends StatelessWidget {
  const AdaptiveLayoutView({super.key});

  static const routeName = 'adaptive';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobileLayout(),
        tabletLayout: (context) => const TabletLayout(),
        desktopLayout: (context) => const DesktopLayout(),
      ),
    );
  }
}
