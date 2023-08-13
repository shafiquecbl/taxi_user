import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/utils/style.dart';

class SearchingDriverSheet extends StatelessWidget {
  const SearchingDriverSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (con) {
      return Container(
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
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
            const SizedBox(height: 20.0),
            Container(
              padding: pagePadding,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAddressRow(
                    context,
                    title: con.pickupAddress.isEmpty
                        ? 'Pickup Address'
                        : con.pickupAddress,
                    color: Theme.of(context).primaryColor,
                    time: '11:24',
                  ),
                  const SizedBox(height: 10.0),
                  const SizedBox(height: 10.0),
                  _buildAddressRow(
                    context,
                    title: con.dropAddress.isEmpty
                        ? 'Dropoff Address'
                        : con.dropAddress,
                    color: Colors.red,
                    time: '',
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddressRow(
    BuildContext context, {
    required String title,
    required Color color,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).hintColor),
        ),
        SizedBox(width: time.isEmpty ? 40 : 10.0),
        Icon(
          Iconsax.location5,
          size: 16.0,
          color: color,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(title,
              style: const TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.normal,
              )),
        ),
      ],
    );
  }
}
