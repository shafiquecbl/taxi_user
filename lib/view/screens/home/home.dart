// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/view/screens/drawer/drawer.dart';
import 'widgets/address_widget.dart';
import 'widgets/bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RideController>(builder: (con) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text(
            'DropUs',
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: const Icon(Iconsax.menu_1),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification),
            ),
          ],
        ),
        body: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: MediaQuery.of(context).size.height /
                  (con.sheetVisible ? 1.8 : 1),
              child: GoogleMap(
                mapType: MapType.normal,
                compassEnabled: true,
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                polylines: con.polylines,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(31.5204, 74.3587),
                  zoom: 10,
                ),
                markers: con.markers,
                onMapCreated: (controller) {
                  con.mapController = controller;
                  con.getCurrentLocation();
                },
              ),
            ),
            Column(
              children: [
                const AddressWidget(),
                _currentLocationWidget(con),
              ],
            )
          ],
        ),
        bottomSheet: con.sheetVisible ? const BookRideSheet() : null,
      );
    });
  }

  Align _currentLocationWidget(RideController con) => Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: con.getCurrentLocation,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.my_location_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              )),
        ),
      );
}
