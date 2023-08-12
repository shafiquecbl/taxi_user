import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:get/get.dart';

class BackgroundWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const BackgroundWidget(
      {required this.title, required this.children, super.key});

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
            color: Colors.grey.withOpacity(0.05),
          ),
          Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Row(
                  children: [
                    const CustomBackButton(),
                    Expanded(
                      child: Center(
                        child: Text(title.tr,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20).copyWith(top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
