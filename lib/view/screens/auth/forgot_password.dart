import 'package:flutter/material.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/common/textfield.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/screens/auth/widget/background_widget.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String countryCode = '+92';
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(title: 'forgot_password', children: [
      Text('forgot_password'.tr,
          style: Theme.of(context).textTheme.headlineLarge),
      const SizedBox(height: 10),
      Text('forgot_password_subtitle'.tr,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: fontWeightNormal)),

      //
      SizedBox(height: getPixels(context, 30)),

      CustomTextField(
        controller: password,
        labelText: 'email'.tr,
        hintText: 'enter_email'.tr,
        prefixIcon: FFIcons.email,
      ),

      const SizedBox(height: 50),
      // sign in button
      CustomButton(
        text: 'reset_password'.tr,
        onPressed: () {},
      ),
    ]);
  }
}
