import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/controller/theme_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:taxi_user/view/screens/auth/login.dart';
import 'package:taxi_user/view/screens/language/language.dart';
import 'package:taxi_user/view/screens/notification/notification.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: Padding(
        padding: pagePadding.copyWith(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconButton(
                  onPressed: pop,
                  icon: Icon(
                    Icons.arrow_back,
                  )),
              const SizedBox(height: 15),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        'https://avatars.githubusercontent.com/u/29775873?v=4'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // name
                      Text('Muhammad Shafique',
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      // email
                      Text('shafiquecbl@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ))
                    ],
                  ))
                ],
              ),
              const SizedBox(height: 40),
              _customTile(context, FFIcons.user, 'profile_info', () {}),
              _customTile(context, FFIcons.notification, 'notifications', () {
                launchScreen(const NotificationScreen());
              }),
              _customTile(context, FFIcons.language, 'language'.tr, () {
                launchScreen(const LanguageScreen());
              }),
              _customTile(context, FFIcons.moon, 'dark_mode'.tr, () {
                ThemeController.to.toggleTheme();
              }, theme: true),
              _customTile(context, FFIcons.info, 'Privay Policy'.tr, () {
                launchScreen(const LanguageScreen());
              }),
              _customTile(context, FFIcons.information, 'Terms & Conditions'.tr,
                  () {
                launchScreen(const LanguageScreen());
              }),
              _customTile(context, FFIcons.logout, 'logout', () {
                launchScreen(const LoginScreen());
              }, color: Theme.of(context).colorScheme.error),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _customTile(
      BuildContext context, IconData icon, String text, Function() onPressed,
      {bool theme = false, Color? color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
          leading: CustomIcon(icon: icon, color: color),
          title: Text(text.tr,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 15,
                    fontWeight: fontWeightNormal,
                  )),
          trailing: theme
              ? GetBuilder<ThemeController>(builder: (themeController) {
                  return CupertinoSwitch(
                    value: themeController.darkTheme,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  );
                })
              : null,
          onTap: onPressed,
        ),
        const CustomDivider(),
      ],
    );
  }
}
