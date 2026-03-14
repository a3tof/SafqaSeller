import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safqaseller/core/helper_functions/on_generate_routes.dart';
import 'package:safqaseller/core/service_locator.dart';
import 'package:safqaseller/core/app/view_model/app_view_model.dart';
import 'package:safqaseller/features/adaptive_layout/view/adaptive_layout_view.dart';
import 'package:safqaseller/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const SafqaSeller());
}

class SafqaSeller extends StatelessWidget {
  const SafqaSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => getIt<AppViewModel>(),
          child: BlocBuilder<AppViewModel, AppState>(
            builder: (context, state) {
              final appViewModel = AppViewModel.get(context);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  fontFamily: appViewModel.getLocale().languageCode == 'ar'
                      ? 'Cairo'
                      : 'Inter',
                ),
                locale: appViewModel.getLocale(),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
            initialRoute: AdaptiveLayoutView.routeName,
            onGenerateRoute: onGenerateRoutes,
            home: const AdaptiveLayoutView(),
              );
            },
          ),
        );
      },
    );
  }
}
