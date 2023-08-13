import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:taxi_user/controller/theme_controller.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/colors.dart';
import 'package:taxi_user/view/base/ripple/ripple.dart';
import 'package:taxi_user/view/screens/home/home.dart';
import 'helper/get_di.dart' as di;
import 'controller/localization_controller.dart';
import 'helper/navigation.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  }
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({required this.languages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: ((themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: themeController.darkTheme
              ? themeController.darkColor == null
                  ? dark()
                  : dark(color: themeController.darkColor!)
              : themeController.lightColor == null
                  ? light()
                  : light(color: themeController.lightColor!),
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(
            AppConstants.languages[0].languageCode,
            AppConstants.languages[0].countryCode,
          ),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(loadingBuilder: (string) {
            return const RipplesAnimation(
              size: 20,
              color: primaryColor,
              child: SizedBox(),
            );
          }),
          home: const HomeScreen(),
        );
      });
    }));
  }
}
