import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const CustomDivider(),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                visualDensity: const VisualDensity(horizontal: -2, vertical: 2),
                leading:
                    const CustomIcon(iconSize: 30, icon: FFIcons.notification),
                title: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                subtitle: Text(
                  '2 min ago',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: fontWeightNormal),
                ),
              );
            }),
      )),
    );
  }
}
