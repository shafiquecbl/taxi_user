import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  Color? _lightColor;
  Color? _darkColor;

  bool get darkTheme => _darkTheme;
  Color? get darkColor => _darkColor;
  Color? get lightColor => _lightColor;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    RideController.to.setMapTheme();
    sharedPreferences.setBool(AppConstants.THEME, _darkTheme);
    update();
  }

  void changeTheme(Color lightColor, Color darkColor) {
    _lightColor = lightColor;
    _darkColor = darkColor;
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstants.THEME) ?? false;
    update();
  }

  static ThemeController get to => Get.find();
}

bool get isDark => ThemeController.to.darkTheme;
