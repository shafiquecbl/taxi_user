import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_user/common/network_image.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/view/base/animation_builder.dart';

class RequestsWidget extends StatelessWidget {
  const RequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        10,
        MediaQuery.of(context).padding.top + 50,
        10,
        35,
      ),
      child: GetBuilder<RideController>(builder: (rideController) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: rideController.drivers.length,
          itemBuilder: (context, index) {
            return CustomAnimationBuilder(
              direction: AnimationDirection.fromLeft,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            child: CustomNetworkImage(
                              url:
                                  'https://avatars.githubusercontent.com/u/29775873?v=4',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      'Suzuki Mehran',
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  // price
                                  Text(
                                    'PKR 900',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: const [
                                  Expanded(
                                    child: Text(
                                      'Muhammad Shafique',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '5 min.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: const [
                                  Icon(
                                    FFIcons.star,
                                    size: 18,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    '4.8',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '(1033)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '822 m',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      radius: 8,
                                      height: 40,
                                      text: 'Decline',
                                      color: Theme.of(context).disabledColor,
                                      onPressed: () =>
                                          rideController.removeDriver(index),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomButton(
                                      radius: 8,
                                      height: 40,
                                      text: 'Accept',
                                      onPressed: () {
                                        rideController.inRide = true;
                                        rideController.drivers = [];
                                        pop();
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        );
      }),
    );
  }
}
