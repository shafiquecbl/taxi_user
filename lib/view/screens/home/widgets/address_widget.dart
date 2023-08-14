// ignore_for_file: depend_on_referenced_packages, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressWidget extends StatefulWidget {
  const AddressWidget({super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (rideController) {
      return Container(
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        padding: pagePadding,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressRow(
              rideController,
              title: rideController.pickupAddress.isEmpty
                  ? 'Pickup Address'
                  : rideController.pickupAddress,
              color: Theme.of(context).primaryColor,
              onPressed: rideController.inRide
                  ? null
                  : () async {
                      await launchScreen(PlacePicker(
                        apiKey: AppConstants.API_KEY,
                        initialPosition: rideController.currentPosition ??
                            const LatLng(31.5204, 74.3587),
                        onPlacePicked: (result) {
                          pop();
                          rideController.pickupAddress =
                              result.formattedAddress!;

                          rideController.startPoint = LatLng(
                              result.geometry!.location.lat,
                              result.geometry!.location.lng);

                          if (rideController.pickupAddress.isNotEmpty &&
                              rideController.dropAddress.isNotEmpty) {
                            rideController.getPolyline();
                          }
                        },
                      ));
                    },
              onClose: () {
                rideController.reset();
                rideController.pickupAddress = '';
              },
            ),
            for (var i = 0; i < 5; i++)
              const VerticalDotsDivider(
                padding: 7,
              ),
            _buildAddressRow(
              rideController,
              title: rideController.dropAddress.isEmpty
                  ? 'Dropoff Address'
                  : rideController.dropAddress,
              color: Colors.red,
              onPressed: rideController.inRide
                  ? null
                  : () async {
                      await launchScreen(PlacePicker(
                        apiKey: AppConstants.API_KEY,
                        initialPosition: rideController.currentPosition ??
                            const LatLng(31.5204, 74.3587),
                        onPlacePicked: (result) {
                          pop();
                          rideController.dropAddress = result.formattedAddress!;

                          rideController.endPoint = LatLng(
                              result.geometry!.location.lat,
                              result.geometry!.location.lng);

                          if (rideController.pickupAddress.isNotEmpty &&
                              rideController.dropAddress.isNotEmpty) {
                            rideController.getPolyline();
                          }
                        },
                      ));
                    },
              onClose: () {
                rideController.reset();
                rideController.dropAddress = '';
              },
            )
          ],
        ),
      );
    });
  }

  Widget _buildAddressRow(
    RideController rideController, {
    required String title,
    required Function()? onPressed,
    required Function() onClose,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Iconsax.location5,
          size: 16.0,
          color: color,
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: InkWell(
            onTap: onPressed,
            child: Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                )),
          ),
        ),
        if (!rideController.inRide)
          InkWell(
            onTap: onClose,
            child: Icon(
              Icons.close,
              size: 20,
              color: Theme.of(context).hintColor,
            ),
          ),
      ],
    );
  }
}
