import 'package:flutter/material.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/view/base/animated_widget.dart';
import 'package:taxi_user/view/screens/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      launchScreen(const LoginScreen(),
          duration: const Duration(milliseconds: 500));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Images.splash,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            color: Colors.grey.withOpacity(0.08),
          ),
          // bottom text
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Food Delivery - Made with ❤️ in Flutter',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          CustomAnimatedWidget(
              child: Center(
            child: Image.asset(
              Images.logo,
              width: 150,
              height: 150,
            ),
          )),
        ],
      ),
    );
  }
}
