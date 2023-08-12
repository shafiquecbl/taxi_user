import 'package:flutter/material.dart';

class CustomAnimatedWidget extends StatefulWidget {
  final Widget child;
  const CustomAnimatedWidget({required this.child, super.key});

  @override
  State<CustomAnimatedWidget> createState() => _CustomAnimatedWidgetState();
}

class _CustomAnimatedWidgetState extends State<CustomAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 0.8, end: 0.4).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          scale: 0.8 + (_logoAnimation.value * (0.8)),
          child: widget.child,
        );
      },
    );
  }
}
