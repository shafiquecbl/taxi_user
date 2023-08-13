import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/network_image.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/controller/theme_controller.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';

class RideSheet extends StatefulWidget {
  const RideSheet({super.key});

  @override
  State<RideSheet> createState() => _RideSheetState();
}

class _RideSheetState extends State<RideSheet> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (con) {
      return Container(
        decoration: BoxDecoration(
          color: isDark
              ? Theme.of(context).cardColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: pagePadding.copyWith(top: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                // your driver is coming in 5 minutes
                const Expanded(
                  child: Text(
                    'Your driver is coming in 2:35',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // cancel button
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Cancel Ride',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
            const CustomDivider(),
            const SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 35,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CustomNetworkImage(
                      url:
                          'https://avatars.githubusercontent.com/u/29775873?v=4',
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Muhammad Shafique',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            Images.car1,
                            width: 100,
                            height: 45,
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: const [
                          Icon(
                            FFIcons.star,
                            color: Colors.orange,
                            size: 16,
                          ),
                          Text(
                            '4.9 (1033)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Spacer(),
                          Text('Toyota Corolla - ABC 123',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const CustomDivider(),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    flex: 60,
                    child: CustomButton(
                      radius: 8,
                      text: 'Message',
                      iconData: Iconsax.message,
                      onPressed: () {},
                    )),
                const SizedBox(width: 10),
                Expanded(
                    flex: 40,
                    child: CustomButton(
                      radius: 8,
                      iconData: Iconsax.call,
                      text: 'Call',
                      color: isDark
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Theme.of(context).cardColor,
                      textColor: Theme.of(context).textTheme.bodyMedium?.color,
                      onPressed: () {},
                    ))
              ],
            )
          ],
        ),
      );
    });
  }
}
