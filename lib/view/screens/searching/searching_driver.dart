// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/view/base/ripple/ripple.dart';

import 'widgets/searching_sheet.dart';

class SearchingDriverScreen extends StatelessWidget {
  const SearchingDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (con) {
      return Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: MediaQuery.of(context).size.height / 1.48,
          child: Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                compassEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                polylines: con.polylines,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(31.5204, 74.3587),
                  zoom: 10,
                ),
                markers: con.markers,
                onMapCreated: (controller) {
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: con.polylines.first.points.first, zoom: 15)));
                },
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                        child: RipplesAnimation(
                      color: Theme.of(context).primaryColor,
                      child: const Icon(
                        Iconsax.location,
                        color: Colors.white,
                      ),
                    )),
                    const SizedBox(height: 20),
                    Text(
                      'Searching for a driver',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).padding.top + 10,
                  left: 0,
                  child: const CustomBackButton())
            ],
          ),
        ),
        bottomSheet: const SearchingDriverSheet(),
      );
    });
  }
}
