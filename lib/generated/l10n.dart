// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: 'Validation message when a required field is empty',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: 'Log in button label',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: 'Sign up button label',
      args: [],
    );
  }

  /// `Stop wasting time!`
  String get onBoardingTitle1 {
    return Intl.message(
      'Stop wasting time!',
      name: 'onBoardingTitle1',
      desc: 'Onboarding page 1 title',
      args: [],
    );
  }

  /// `Safqa transforms the long auction process into a fast, guaranteed digital experience, manage your auctions wherever you are.`
  String get onBoardingSubtitle1 {
    return Intl.message(
      'Safqa transforms the long auction process into a fast, guaranteed digital experience, manage your auctions wherever you are.',
      name: 'onBoardingSubtitle1',
      desc: 'Onboarding page 1 subtitle',
      args: [],
    );
  }

  /// `Smart Bidding`
  String get onBoardingTitle2 {
    return Intl.message(
      'Smart Bidding',
      name: 'onBoardingTitle2',
      desc: 'Onboarding page 2 title',
      args: [],
    );
  }

  /// `Participate in real-time bidding, or let the Proxy Bidding (Auto-Bid) system win automatically within your defined limit.`
  String get onBoardingSubtitle2 {
    return Intl.message(
      'Participate in real-time bidding, or let the Proxy Bidding (Auto-Bid) system win automatically within your defined limit.',
      name: 'onBoardingSubtitle2',
      desc: 'Onboarding page 2 subtitle',
      args: [],
    );
  }

  /// `Experience Designed For You`
  String get onBoardingTitle3 {
    return Intl.message(
      'Experience Designed For You',
      name: 'onBoardingTitle3',
      desc: 'Onboarding page 3 title',
      args: [],
    );
  }

  /// `A modern, bilingual (Arabic/English) design that allows you to navigate and bid seamlessly from any device.`
  String get onBoardingSubtitle3 {
    return Intl.message(
      'A modern, bilingual (Arabic/English) design that allows you to navigate and bid seamlessly from any device.',
      name: 'onBoardingSubtitle3',
      desc: 'Onboarding page 3 subtitle',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
