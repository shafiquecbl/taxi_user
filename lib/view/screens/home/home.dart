// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/colors.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _pickupAddress = '';
  String _dropoffAddress = '';
  int _selecteRide = 0;
  late GoogleMapController mapController;
  Set<Marker> markers = const <Marker>{};

  void _checkPermission(Function callback, BuildContext context) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // address.text = '';
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
      // address.text = '';
      // openAppSettings();
    } else {
      callback();
    }
  }

  void _getCurrentLocation() {
    _checkPermission(() async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );

      setState(() {
        // add marker
        markers = {
          Marker(
            markerId: const MarkerId('current'),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarker,
          )
        };
      });
    }, context);
  }

  List<String> rideType = [
    'Ride AC',
    'Ride',
    'Ride Mini',
    'Bike',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              compassEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(31.5204, 74.3587),
                zoom: 10,
              ),
              markers: markers,
              onMapCreated: (controller) {
                mapController = controller;
                _getCurrentLocation();
              },
            ),
            Column(
              children: [
                _buildAppBar(context),
                const SizedBox(height: 20),
                _buildAddress(context),
                Align(
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
                                color: Theme.of(context)
                                    .shadowColor
                                    .withOpacity(0.1),
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
                ),
              ],
            )
          ],
        ),
        bottomSheet: _buildBottomSheet());
  }

  Container _buildAddress(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
            title: _pickupAddress.isEmpty ? 'Pickup Address' : _pickupAddress,
            color: Theme.of(context).primaryColor,
            onPressed: () async {
              await launchScreen(PlacePicker(
                apiKey: AppConstants.API_KEY,
                initialPosition: const LatLng(31.5204, 74.3587),
                onPlacePicked: (result) {
                  pop();
                  setState(() {
                    _pickupAddress = result.formattedAddress!;
                  });
                },
              ));
            },
            onClose: () {
              setState(() {
                _pickupAddress = '';
              });
            },
          ),
          for (var i = 0; i < 5; i++)
            const VerticalDotsDivider(
              padding: 7,
            ),
          _buildAddressRow(
            title:
                _dropoffAddress.isEmpty ? 'Dropoff Address' : _dropoffAddress,
            color: Colors.red,
            onPressed: () async {
              await launchScreen(PlacePicker(
                apiKey: AppConstants.API_KEY,
                initialPosition: const LatLng(31.5204, 74.3587),
                onPlacePicked: (result) {
                  pop();
                  setState(() {
                    _dropoffAddress = result.formattedAddress!;
                  });
                },
              ));
            },
            onClose: () {
              setState(() {
                _dropoffAddress = '';
              });
            },
          )
        ],
      ),
    );
  }

  Container _buildBottomSheet() {
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
              height: 85,
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
                      width: 130,
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
                                    width: 90,
                                    height: 40,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  rideType[index],
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal,
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAddressRow({
    required String title,
    required Function() onPressed,
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
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                )),
          ),
        ),
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

  Container _buildAppBar(BuildContext context) {
    return Container(
      padding: pagePadding.copyWith(
          top: MediaQuery.of(context).padding.top, bottom: 5),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.menu_1),
          ),
          Text(
            'DropUs',
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.notification),
          ),
        ],
      ),
    );
  }
}
