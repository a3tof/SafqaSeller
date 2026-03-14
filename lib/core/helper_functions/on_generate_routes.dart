import 'package:flutter/material.dart';
import 'package:safqaseller/features/adaptive_layout/view/adaptive_layout_view.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/desktop_layout.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/mobile_layout.dart';
import 'package:safqaseller/features/adaptive_layout/view/widgets/tablet_layout.dart';
import 'package:safqaseller/features/auth/view/signin_view.dart';
import 'package:safqaseller/features/auth/view/signup_view.dart';
import 'package:safqaseller/features/home/view/home_screen_view.dart';
import 'package:safqaseller/features/on_boarding/view/on_boarding_view.dart';
import 'package:safqaseller/features/splash/view/splash_screen_view.dart';


Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case TabletLayout.routeName:
      return MaterialPageRoute(builder: (_) => const TabletLayout());
    case DesktopLayout.routeName:
      return MaterialPageRoute(builder: (_) => const DesktopLayout());
    case AdaptiveLayoutView.routeName:
      return MaterialPageRoute(builder: (_) => const AdaptiveLayoutView());
    case MobileLayout.routeName:
      return MaterialPageRoute(builder: (_) => const MobileLayout());
    case SplashView.routeName:
      return MaterialPageRoute(builder: (_) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (_) => const OnBoardingView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (_) => const SigninView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (_) => const SignupView());
    case HomeScreenView.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreenView());
    default:
      return MaterialPageRoute(builder: (_) => const SplashView());
  }
}
