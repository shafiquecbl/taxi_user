import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:get/get.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // or
        Padding(
          padding: const EdgeInsets.fromLTRB(60, 30, 60, 20),
          child: Row(
            children: [
              const Expanded(child: CustomDivider()),
              const SizedBox(width: 10),
              Text(
                'or_continue_with'.tr,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).hintColor,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(width: 10),
              const Expanded(child: CustomDivider()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SocialLoginButton(
                title: 'Google',
                image: Images.google,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SocialLoginButton(
                title: 'Facebook',
                image: Images.facebook,
                onPressed: () {},
              ),
            ),
          ],
        ),
        // const SizedBox(height: 20),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SocialLoginButton(
        //       title: 'Apple',
        //       image: Images.apple,
        //       onPressed: () {},
        //     ),
        //   ],
        // )
      ],
    );
  }
}
