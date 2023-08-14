// ignore_for_file: depend_on_referenced_packages, unused_import, prefer_final_fields

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/common/icons.dart';
import 'package:taxi_user/common/primary_button.dart';
import 'package:taxi_user/controller/ride_controller.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/colors.dart';
import 'package:taxi_user/utils/icons.dart';
import 'package:taxi_user/utils/images.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapsRepo {
  MapsRepo._();
  static final MapsRepo instance = MapsRepo._();

  // markes

  Future<Set<Marker>> getMarkers(LatLng start, LatLng end) async {
    final markerSouce =
        await convertAssetToUnit8List(Images.pin_start, width: 80);
    final markerDestination =
        await convertAssetToUnit8List(Images.pin_end, width: 80);
    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('start'),
        position: start,
        icon: BitmapDescriptor.fromBytes(markerDestination),
      ),
    );
    markers.add(Marker(
      markerId: const MarkerId('end'),
      position: end,
      icon: BitmapDescriptor.fromBytes(markerSouce),
    ));

    return markers;
  }

  Future<Uint8List> convertAssetToUnit8List(String imagePath,
      {int width = 50}) async {
    ByteData data = await rootBundle.load(imagePath);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: width,
    );
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // polylines

  Future<Set<Polyline>> getPolyline(LatLng start, LatLng end) async {
    Set<Polyline> polylines = {};
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      AppConstants.API_KEY,
      PointLatLng(
        start.latitude,
        start.longitude,
      ),
      PointLatLng(end.latitude, end.longitude),
    );

    if (result.points.isNotEmpty) {
      final List<LatLng> polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      polylines.add(Polyline(
        polylineId: const PolylineId("path"),
        color: primaryColor,
        width: 5,
        points: polylineCoordinates,
      ));
    }
    return polylines;
  }

  num fitBoundsZoomLevel(LatLngBounds bounds) {
    double globeWidth =
        256; // Google Maps global width in pixels at zoom level 0
    int zoomMax = 21;

    double latDiff = bounds.northeast.latitude - bounds.southwest.latitude;
    double lngDiff = bounds.northeast.longitude - bounds.southwest.longitude;

    double latZoom = log(globeWidth * 360 / (256 * latDiff)) / ln2;
    double lngZoom = log(globeWidth * 360 / (256 * lngDiff)) / ln2;

    double result = min(latZoom, lngZoom);

    // Calculate desired zoom level based on map height
    double heightZoom = log(300 * 360 / (256 * latDiff)) / ln2;

    return (min(result, heightZoom) > zoomMax
        ? zoomMax
        : min(result, heightZoom));
  }

  CameraPosition getCameraPosition(LatLng start, LatLng end) {
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(min(start.latitude, end.latitude),
          min(start.longitude, end.longitude)),
      northeast: LatLng(max(start.latitude, end.latitude),
          max(start.longitude, end.longitude)),
    );

    double centerLatitude =
        (bounds.southwest.latitude + bounds.northeast.latitude) / 2;
    double centerLongitude =
        (bounds.southwest.longitude + bounds.northeast.longitude) / 2;

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(centerLatitude, centerLongitude),
      zoom: fitBoundsZoomLevel(bounds).toDouble(),
    );

    return cameraPosition;
  }

  // get current location
  void getCurrentLocation(Function(Position position) callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else if (permission == LocationPermission.deniedForever) {
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      callback(position);
    }
  }

  // get distance in KM
  double getDistance(LatLng start, LatLng end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return double.parse((distanceInMeters / 1000).toStringAsFixed(2));
  }

  // calculate fare in PKR
  double calculateFare(double distance) {
    double fare = 0.0;
    if (distance <= 1) {
      fare = 100;
    } else {
      fare = 100 + (distance - 1) * 50;
    }
    return fare == 100 ? fare : fare + 100;
  }

  // get duration in  minutes
  String getDuration(LatLng start, LatLng end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    return ((distanceInMeters / 1000) * 5).toStringAsFixed(0);
  }

  // get formatted adddress
  Future<String> getFormattedAddress(LatLng position) async {
    return await FlutterAddressFromLatLng().getFormattedAddress(
      latitude: position.latitude,
      longitude: position.longitude,
      googleApiKey: AppConstants.API_KEY,
    );
  }
}
