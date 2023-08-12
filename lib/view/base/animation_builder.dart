import 'package:flutter/material.dart';

enum AnimationDirection {
  fromTop,
  fromBottom,
  fromLeft,
  fromRight,
}

class CustomAnimationBuilder extends StatelessWidget {
  final Widget child;
  final AnimationDirection direction;
  const CustomAnimationBuilder({
    required this.child,
    required this.direction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset getOffset() {
      switch (direction) {
        case AnimationDirection.fromTop:
          return const Offset(0.0, 50.0);
        case AnimationDirection.fromBottom:
          return const Offset(0.0, -50.0);
        case AnimationDirection.fromLeft:
          return const Offset(50.0, 0.0);
        case AnimationDirection.fromRight:
          return const Offset(-50.0, 0.0);
      }
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: getOffset() * (1 - value),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
