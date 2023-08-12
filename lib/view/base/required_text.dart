
import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  final String text;
  final bool required;
  final Color? color;
  final TextStyle? style;
  const RequiredText(
      {required this.text,
      this.required = false,
      this.color,
      this.style,
      super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: text,
      style: style ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: color),
      children: [
        if (required)
          TextSpan(
            text: ' *',
            style: style != null
                ? style!.copyWith(color: Colors.red)
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.error),
          ),
      ],
    ));
  }
}
