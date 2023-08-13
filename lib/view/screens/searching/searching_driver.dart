// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/theme/maps.dart';
import 'package:taxi_user/view/screens/searching/widgets/searching_widget.dart';
import 'widgets/requests_widget.dart';
import 'widgets/searching_sheet.dart';

class SearchingDriverScreen extends StatelessWidget {
  const SearchingDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (con) {
      return WillPopScope(
        onWillPop: () async {
          con.drivers = [];
          return true;
        },
        child: Scaffold(
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: MediaQuery.of(context).size.height / 1.3,
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
                    controller.setMapStyle(MAPS_THEME);
                    controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: con.polylines.first.points.first,
                            zoom: 15)));
                  },
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: con.drivers.isNotEmpty
                      ? const RequestsWidget()
                      : const SearchingWidget(),
                ),
                Positioned(
                    top: MediaQuery.of(context).padding.top,
                    right: 10,
                    child: TextButton(
                        onPressed: () {
                          con.drivers = [];
                          pop();
                        },
                        child: Text(
                          'Cancel',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.red,
                                  ),
                        )))
              ],
            ),
          ),
          bottomSheet: const SearchingDriverSheet(),
        ),
      );
    });
  }
}
