import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String? image;
  final IconData? icon;
  final VoidCallback? onTap;
  final double iconSize;
  final double border;
  final Color? color;
  final Color? iconColor;
  final double padding;
  const CustomIcon(
      {this.icon,
      this.image,
      this.onTap,
      this.iconSize = 20,
      this.border = 30,
      this.color,
      this.iconColor = Colors.white,
      this.padding = 5,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(border)),
        ),
        padding: EdgeInsets.all(padding),
        child: image != null
            ? Image.asset(image!,
                width: iconSize, height: iconSize, color: iconColor)
            : Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
