import 'package:flutter/material.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/common/textfield.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/screens/auth/widget/social_login_widget.dart';
import 'package:get/get.dart';
import 'package:taxi_user/view/screens/home/home.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String countryCode = '+92';
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20).copyWith(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('welcome'.tr,
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 10),
            Text('signin_welcome_subtitle'.tr,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: fontWeightNormal)),

            //
            SizedBox(height: getPixels(context, 30)),

            CustomTextField(
              controller: email,
              labelText: 'email'.tr,
              hintText: 'enter_email'.tr,
              prefixIcon: FFIcons.email,
            ),

            CustomTextField(
              controller: password,
              labelText: 'password'.tr,
              hintText: 'enter_password'.tr,
              prefixIcon: FFIcons.lock,
              suffixIcon: Icon(FFIcons.eye, color: Theme.of(context).hintColor),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                // remember me
                Checkbox(
                  visualDensity: const VisualDensity(horizontal: -4),
                  value: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onChanged: (value) {},
                ),
                Text('remember_me'.tr,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                        fontWeight: FontWeight.normal)),
                const Spacer(),
                // forgot password
                TextButton(
                  onPressed: () {
                    launchScreen(const ForgotPasswordScreen());
                  },
                  child: Text('forgot_password_text'.tr,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal)),
                ),
              ],
            ),

            const SizedBox(height: 30),
            // sign in button
            CustomButton(
              text: 'signin'.tr,
              onPressed: () => launchScreen(const HomeScreen()),
            ),

            const SocialLoginWidget(),

            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }
}
