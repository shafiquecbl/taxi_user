import 'package:flutter/material.dart';
import 'package:taxi_user/common/network_image.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/utils/icons.dart';

class RequestsWidget extends StatelessWidget {
  const RequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        10,
        MediaQuery.of(context).padding.top + 50,
        10,
        15,
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
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
                                  height: 40,
                                  text: 'Decline',
                                  color: Theme.of(context).disabledColor,
                                  onPressed: () {},
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                  height: 40,
                                  text: 'Accept',
                                  onPressed: () {},
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
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
