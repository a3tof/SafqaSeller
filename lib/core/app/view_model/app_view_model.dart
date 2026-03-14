import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqaseller/core/storage/cache_helper.dart';
import 'package:safqaseller/core/storage/cache_keys.dart';
import 'package:safqaseller/core/service_locator.dart';

part 'app_view_model_state.dart';

enum LanguageState { english, arabic, system }

class AppViewModel extends Cubit<AppState> {
  AppViewModel() : super(AppInitialState()) {
    _loadLanguage();
  }

  static AppViewModel get(context) => BlocProvider.of(context);

  //*select language

  LanguageState currentLanguage = LanguageState.system;

  Future<void> selectLanguage(LanguageState language) async {
    currentLanguage = language;
    await getIt<CacheHelper>().saveData(
      key: CacheKeys.language,
      value: currentLanguage.name,
    );
    emit(LanguageSelectedState());
  }

  Future<void> _loadLanguage() async {
    final dynamic savedLanguage = getIt<CacheHelper>().getData(
      key: CacheKeys.language,
    );
    if (savedLanguage is String) {
      currentLanguage = LanguageState.values.firstWhere(
        (element) => element.name == savedLanguage,
        orElse: () => LanguageState.system,
      );
    }
    emit(LanguageSelectedState());
  }

  //*get language

  String getLanguage() {
    //*get device language
    String deviceLanguage = PlatformDispatcher.instance.locale.languageCode;

    switch (currentLanguage) {
      case LanguageState.english:
        return 'en';
      case LanguageState.arabic:
        return 'ar';
      case LanguageState.system:
        return deviceLanguage;
    }
  }

  //*get locale
  Locale getLocale() {
    String languageCode = getLanguage();
    // Ensure we only return supported locales (en or ar)
    if (languageCode == 'ar') {
      return const Locale('ar');
    }
    return const Locale('en');
  }
}
