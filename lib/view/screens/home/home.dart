// ignore_for_file: depend_on_referenced_packages, unused_import, prefer_final_fields

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/data/repository/maps_repo.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/colors.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:taxi_user/view/screens/drawer/drawer.dart';
import 'widgets/address_widget.dart';
import 'widgets/bottom_sheet.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = <Marker>{};
  Set<Polyline> _polylines = {};
  double? _distance;
  String? _duration;
  bool _sheetVisible = false;
  double? _fare;
  LatLng? _currentPosition;

  // scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _getCurrentLocation() {
    MapsRepo.instance.getCurrentLocation((position) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );
    });
  }

  void _getPolyline(LatLng start, LatLng end) async {
    _polylines.clear();
    _polylines = await MapsRepo.instance.getPolyline(start, end);
    if (_polylines.isNotEmpty) {
      _addMarkers(start, end);
    }
  }

  void _addMarkers(LatLng start, LatLng end) async {
    _markers.clear();
    _markers = await MapsRepo.instance.getMarkers(start, end);
    _distance = MapsRepo.instance.getDistance(start, end);
    _fare = MapsRepo.instance.calculateFare(_distance!);
    _duration = MapsRepo.instance.getDuration(start, end);
    setState(() {
      _sheetVisible = true;
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            MapsRepo.instance.getCameraPosition(start, end)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(
          'DropUs',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
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
            height:
                _sheetVisible ? MediaQuery.of(context).size.height / 1.8 : null,
            child: GoogleMap(
              mapType: MapType.normal,
              compassEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              polylines: _polylines,
              initialCameraPosition: const CameraPosition(
                target: LatLng(31.5204, 74.3587),
                zoom: 10,
              ),
              markers: _markers,
              onMapCreated: (controller) {
                mapController = controller;
                _getCurrentLocation();
              },
            ),
          ),
          Column(
            children: [
              AddressWidget(
                initialPostition: _currentPosition,
                onSelected: _getPolyline,
                onClear: () {
                  setState(() {
                    _polylines.clear();
                    _markers.clear();
                    _distance = 0.0;
                    _duration = null;
                    _fare = 0.0;
                    _sheetVisible = false;
                  });
                },
              ),
              _currentLocationWidget(),
            ],
          )
        ],
      ),
      bottomSheet: _sheetVisible
          ? BookRideSheet(
              distance: _distance,
              fare: _fare,
              duration: _duration,
            )
          : null,
    );
  }

  Align _currentLocationWidget() => Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: _getCurrentLocation,
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
