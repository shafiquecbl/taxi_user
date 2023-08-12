import 'package:flutter/material.dart';
import 'package:get/get.dart';

pop() => Navigator.pop(Get.context!);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Launch a new screen
launchScreen(Widget child, {bool isNewTask = false, Duration? duration}) {
  if (isNewTask) {
    Navigator.of(Get.context!).pushAndRemoveUntil(
        CustomPageRoute(
          child: child,
          curve: Curves.easeInOut,
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ),
        (route) => false);
  } else {
    Navigator.of(Get.context!).push(CustomPageRoute(
      child: child,
      curve: Curves.easeInOut,
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ));
  }
}

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Curve curve;
  final Offset begin;
  final Offset end;

  CustomPageRoute(
      {required this.child,
      required this.curve,
      required this.begin,
      required this.end})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            final tween = Tween(begin: begin, end: end);
            final curvedAnimation =
                CurvedAnimation(parent: animation, curve: curve);
            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.9, end: 1.0)
                    .animate(curvedAnimation),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 250),
        );
}
