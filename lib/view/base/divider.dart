import 'package:flutter/material.dart';
import 'package:taxi_user/controller/theme_controller.dart';
import 'package:get/get.dart';

class CustomDivider extends StatelessWidget {
  final double padding;
  final double thickness;
  const CustomDivider({this.padding = 5, this.thickness = 1, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: GetBuilder<ThemeController>(builder: (con) {
        return Divider(
            height: 0,
            thickness: thickness,
            color: con.darkTheme ? Colors.grey[800] : Colors.grey[300]!);
      }),
    );
  }
}

class VerticalDotsDivider extends StatelessWidget {
  final double padding;
  const VerticalDotsDivider({this.padding = 22.5, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1, horizontal: padding),
      width: 1,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
      ),
    );
  }
}
