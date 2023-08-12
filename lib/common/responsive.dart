import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static bool isWeb() {
    return MediaQuery.of(Get.context!).size.width >= 1024;
  }

  static bool isTablet() {
    return MediaQuery.of(Get.context!).size.width >= 600 &&
        MediaQuery.of(Get.context!).size.width <= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1024) {
          return largeScreen;
        } else if (constraints.maxWidth <= 1024 &&
            constraints.maxWidth >= 600) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
