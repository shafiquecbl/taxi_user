import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmallCupertinoSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SmallCupertinoSwitch(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 40.0,
        height: 24.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: value ? Theme.of(context).primaryColor : Colors.transparent,
          border: Border.all(
            width: 1.0,
            color: value
                ? Theme.of(context).primaryColor
                : CupertinoColors.inactiveGray,
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: value ? 18.0 : 2.0,
              top: 2,
              child: Container(
                width: 18.0,
                height: 18.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: value
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
