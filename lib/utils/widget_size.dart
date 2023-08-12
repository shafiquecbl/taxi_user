// ignore_for_file: non_constant_identifier_names

import 'package:taxi_user/common/responsive.dart';

class CustomSize {
  CustomSize._init();
  static CustomSize get instance => CustomSize._init();

  int get restaurantCrossAxisCount => ResponsiveWidget.isTablet()
      ? 2
      : ResponsiveWidget.isWeb()
          ? 3
          : 1;

  // restaurant or store
  double get restaurantChildAspectRatio => ResponsiveWidget.isTablet()
      ? 5.6
      : ResponsiveWidget.isWeb()
          ? 6.25
          : 4.4;

  // food or product
  double get foodChildAspectRatio => ResponsiveWidget.isTablet()
      ? 3.65
      : ResponsiveWidget.isWeb()
          ? 5.25
          : 2.85;

  // category sheet
  int get categoryCrossAxisCount => ResponsiveWidget.isTablet()
      ? 6
      : ResponsiveWidget.isWeb()
          ? 9
          : 3;

  double get categoryChildAspectRatio => 1.2;

  // category sheet
  int get restaurantInfoCrossAxisCount => ResponsiveWidget.isTablet()
      ? 3
      : ResponsiveWidget.isWeb()
          ? 4
          : 2;

  double get restaurantInfoChildAspectRatio => ResponsiveWidget.isTablet()
      ? 8
      : ResponsiveWidget.isWeb()
          ? 10
          : 5;

  // order widget
  int get orderCrossAxisCount => ResponsiveWidget.isTablet()
      ? 2
      : ResponsiveWidget.isWeb()
          ? 3
          : 1;
  double get orderChildAspectRatio => ResponsiveWidget.isTablet()
      ? 2.3
      : ResponsiveWidget.isWeb()
          ? 2.5
          : 1.6;

  static double foodWidth_H = 165;
  static double foodHeight_H = 200;
  static double foodImageHeight_H = 110;

  static double foodImageWidth_V = 135;
  static double foodImageHeight_V = 115;

  static double restaurantHeight_H = 175;
  static double restaurantImageWidth_V = 125;
  static double restaurantImageHeight_V = 85;

  double get spacing => 15;
}
