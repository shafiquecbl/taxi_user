import 'package:flutter/material.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/required_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final bool float;
  final bool outlined;
  final int? maxLines;
  final bool required;

  const CustomTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.padding,
      this.contentPadding,
      this.validator,
      this.onChanged,
      this.onSubmitted,
      this.keyboardType,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.enabled = true,
      this.float = false,
      this.outlined = false,
      this.maxLines,
      this.required = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (!float)
            if (labelText != null) ...[
              Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: RequiredText(text: labelText!, required: required)),
              const SizedBox(height: 5),
            ],
          TextFormField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            keyboardType: keyboardType,
            textInputAction: textInputAction ?? TextInputAction.next,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            maxLines: maxLines,
            decoration: InputDecoration(
                floatingLabelBehavior: float
                    ? FloatingLabelBehavior.always
                    : FloatingLabelBehavior.never,
                prefixIcon: prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        size: 24,
                        color: AppConstants.isOutline
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).hintColor,
                      )
                    : null,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
                label: float
                    ? RequiredText(
                        text: labelText!,
                        required: required,
                        color: Theme.of(context).hintColor)
                    : null,
                hintText: hintText,
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context),
                disabledBorder: border(context),
                focusedBorder:
                    border(context, color: Theme.of(context).primaryColor),
                errorBorder:
                    border(context, color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context),
                filled: AppConstants.isOutline ? false : true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: contentPadding ?? const EdgeInsets.all(18),
                suffixIcon: suffixIcon),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ??
              (outlined || AppConstants.isOutline
                  ? Theme.of(context).dividerColor
                  : Theme.of(context).cardColor),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(radius),
      );
}

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  const CustomDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.padding,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          DropdownButtonFormField(
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: hintText,
                labelStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Theme.of(context).hintColor),
                enabledBorder: border(context),
                focusedBorder:
                    border(context, color: Theme.of(context).primaryColor),
                errorBorder:
                    border(context, color: Theme.of(context).colorScheme.error),
                focusedErrorBorder: border(context),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                contentPadding: const EdgeInsets.all(15),
                suffixIcon: suffixIcon),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.normal),
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

InputBorder border(BuildContext context, {Color? color}) => OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? Theme.of(context).dividerColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(5),
    );
