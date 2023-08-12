// ignore_for_file: constant_identifier_names

import 'package:taxi_user/data/model/language.dart';
import 'images.dart';

class AppConstants {
  static const String API_KEY = 'AIzaSyDdJ8uMExIeu4qnV325riYEz1RArZqLz0s';
  static const String APP_NAME = 'Food Delivery';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static bool get isOutline => false;
}
