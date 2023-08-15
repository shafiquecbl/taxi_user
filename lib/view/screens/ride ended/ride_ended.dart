import 'package:flutter/material.dart';
import 'package:taxi_user/common/network_image.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/controller/theme_controller.dart';
import 'package:taxi_user/utils/colors.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:taxi_user/view/screens/searching/widgets/searching_sheet.dart';

Future<void> rideEndedDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const RideEndedDialog();
    },
  );
}

class RideEndedDialog extends StatelessWidget {
  const RideEndedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.success,
                color: Theme.of(context).primaryColor,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your ride has ended',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AddressPlaceholder(
                pickupAddress: RideController.to.pickupAddress,
                dropAddress: RideController.to.dropAddress,
                time: '11:24',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RideEndedDialog1 extends StatelessWidget {
  const RideEndedDialog1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ClipPath(
        clipper: ZigZagClipper(),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRow(leading: 'Ride Type', trailing: 'Ride  AC'),
              _buildRow(leading: 'Date', trailing: '8 Aug 202, 11:24 AM'),
              _buildRow(leading: 'Ride ID', trailing: '#123456789'),
              _buildRow(leading: 'Total', trailing: 'PKR 1200'),
              _buildRow(leading: 'Payment Type', trailing: 'Card'),
              const CustomDivider(padding: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
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
                        const Text(
                          'Muhammad Shafique',
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              const Icon(
                                FFIcons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                            const Text(
                              '4.9 (You Rated)',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const CustomDivider(padding: 15),
              AddressPlaceholder(
                pickupAddress: RideController.to.pickupAddress,
                dropAddress: RideController.to.dropAddress,
                time: '11:24',
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // distance
                        const Text(
                          '12.5 KM',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Distance',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // distance
                        const Text(
                          '14.00 mins',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Duration',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                width: 150,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:
                      isDark ? Theme.of(context).disabledColor : Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    // help icon
                    const Icon(
                      Icons.help,
                      color: primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Need Help?',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: !isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildRow({required String leading, required String trailing}) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leading,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              trailing,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      );
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double factor = 0;
    Path path = Path();
    path.moveTo(factor, 0);
    path.arcToPoint(Offset(0, factor),
        radius: const Radius.circular(0), clockwise: false);

    path.lineTo(0, size.height);
    double x = 0;
    double y = size.height;
    double increment = size.width / 50;

    while (x < size.width) {
      if (x + increment > size.width) {
        x += size.width - x;
      } else {
        x += increment;
      }

      y = (y == size.height) ? size.height - increment : size.height;
      path.lineTo(x, y);
    }
    path.lineTo(size.width, factor);
    path.arcToPoint(Offset(size.width - factor, 0),
        radius: const Radius.circular(8), clockwise: false);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper old) {
    return old != this;
  }
}
