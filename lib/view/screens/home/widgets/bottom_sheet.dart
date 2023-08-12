import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/utils/style.dart';

class BookRideSheet extends StatefulWidget {
  const BookRideSheet({super.key});

  @override
  State<BookRideSheet> createState() => _BookRideSheetState();
}

class _BookRideSheetState extends State<BookRideSheet> {
  int _selecteRide = 0;
  List<String> rideType = [
    'Ride AC',
    'Ride',
    'Ride Mini',
    'Bike',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
      padding: pagePadding.copyWith(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 75,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      setState(() {
                        _selecteRide = index;
                      });
                    },
                    child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selecteRide == index
                              ? Colors.blue
                              : Theme.of(context).dividerColor,
                        ),
                        color: _selecteRide == index
                            ? Colors.blue.withOpacity(0.2)
                            : null,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.all(10).copyWith(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'assets/images/car${index + 1}.png',
                                    height: 35,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  rideType[index],
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_selecteRide == index)
                            Positioned(
                              top: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Iconsax.info_circle,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
                itemCount: rideType.length,
              )),
          const SizedBox(height: 20),

          // offer your fair field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  Iconsax.dollar_circle,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Offer Your Fair',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          //  comments field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: const [
                Icon(
                  Iconsax.message,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Comments',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          CustomButton(
            text: 'Book Ride',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
