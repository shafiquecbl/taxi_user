import 'package:flutter/material.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/view/screens/auth/login.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.intro,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // title
                const Text(
                  'Drop US',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                // description
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget elementum aliquam.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // button
                CustomButton(
                  text: 'Create New Account',
                  onPressed: () {},
                ),
                const SizedBox(height: 10),
                CustomButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  text: 'Login Account',
                  onPressed: () => launchScreen(const LoginScreen()),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
