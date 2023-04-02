import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/key_constant.dart';
import '../dependency_injection.dart';

class AppLanguage {
  /// App will Support: (Also add or edit .arb files respectively)
  static const String az = "az";
  static const String en = "en";

  /// Default Language. Will be set when app is not supports device's language itself.

  static Locale defaultLanguage = const Locale(az);

  /// List languages, which are supported by application
  static List<Locale> supportedLanguages = [
    const Locale(en),
    const Locale(az),
  ];

  static updateLocale(String name) async {
    SharedPreferences sharedPreferences = locator.get<SharedPreferences>();

    bool result =
        await sharedPreferences.setString(KeyConst.sk_locale_name, name);
    if (result) Get.updateLocale(Locale(name));
  }

  // static Locale currentLocale() {
  //   SharedPreferences sharedPreferences = locator.get<SharedPreferences>();
  //   Locale currentLocale =
  //       optionOf(sharedPreferences.getString("sk_locale_name")).fold(
  //           () => defaultLanguage,
  //           (a) =>
  //               Locale(sharedPreferences.getString(KeyConst.sk_locale_name)!));

  //   if (AppLocalizations.supportedLocales.contains(currentLocale)) {
  //     return currentLocale;
  //   } else {
  //     return defaultLanguage;
  //   }
  // }

  ///Singleton factory
  static final AppLanguage _instance = AppLanguage._internal();

  factory AppLanguage() {
    return _instance;
  }

  AppLanguage._internal();
}
