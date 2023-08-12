import 'package:flutter/material.dart';
import 'package:taxi_user/controller/localization_controller.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:get/get.dart';
import 'icons.dart';
import 'primary_button.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8)
          .copyWith(left: !isLtr ? 0 : 16, right: !isLtr ? 16 : 0),
      child: CustomIcon(
        icon: FFIcons.leftArrow2,
        iconSize: 28,
        border: 8,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final String image, title;
  final VoidCallback onPressed;
  const SocialLoginButton(
      {required this.image,
      required this.title,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        radius: 32,
        isOutline: true,
        height: 55,
        width: MediaQuery.of(context).size.width / 2 - 30,
        icon: Image.asset(image, height: 24, width: 24),
        text: title,
        color: Colors.transparent,
        textColor: Theme.of(context).textTheme.bodyLarge!.color,
        onPressed: onPressed);
  }
}

class AnimatedTabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  final bool small;
  final Color? color;
  const AnimatedTabButton(
      {required this.text,
      required this.onTap,
      this.selected = false,
      this.small = false,
      this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: small ? 40 : 45,
          decoration: BoxDecoration(
            color: selected
                ? color ?? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Theme.of(context)
                          .hintColor
                          .withOpacity(Get.isDarkMode ? 0.1 : 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
