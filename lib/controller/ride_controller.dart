// ignore_for_file: depend_on_referenced_packages, prefer_final_fields

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_user/common/snackbar.dart';
import 'package:taxi_user/data/repository/maps_repo.dart';
import 'package:taxi_user/theme/maps.dart';

class RideController extends GetxController implements GetxService {
  static RideController get to => Get.find<RideController>();

  late GoogleMapController _mapController;
  Set<Marker> _markers = <Marker>{};
  Set<Polyline> _polylines = {};
  bool _sheetVisible = false;
  LatLng? _currentPosition;

  double? _distance;
  double? _fare;
  String? _duration;
  int _rideType = 0;

  String _pickupAddress = '';
  String _dropAddress = '';
  bool _addressVisible = true;
  LatLng _startPoint = const LatLng(37.7749, -122.4194);
  LatLng _endPoint = const LatLng(34.0522, -118.2437);

  List<String> _drivers = [];
  bool _inRide = false;

  double? get distance => _distance;
  double? get fare => _fare;
  String? get duration => _duration;
  int get rideType => _rideType;

  bool get sheetVisible => _sheetVisible;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polylines => _polylines;
  LatLng? get currentPosition => _currentPosition;

  bool get addressVisible => _addressVisible;
  String get pickupAddress => _pickupAddress;
  String get dropAddress => _dropAddress;
  LatLng get startPoint => _startPoint;
  LatLng get endPoint => _endPoint;

  List<String> get drivers => _drivers;
  bool get inRide => _inRide;

  set mapController(GoogleMapController value) {
    _mapController = value;
    update();
  }

  set markers(Set<Marker> value) {
    _markers = value;
    update();
  }

  set polylines(Set<Polyline> value) {
    _polylines = value;
    update();
  }

  set sheetVisible(bool value) {
    _sheetVisible = value;
    update();
  }

  set currentPosition(LatLng? value) {
    _currentPosition = value;
    update();
  }

  set distance(double? value) {
    _distance = value;
    update();
  }

  set fare(double? value) {
    _fare = value;
    update();
  }

  set duration(String? value) {
    _duration = value;
    update();
  }

  set rideType(int value) {
    _rideType = value;
    update();
  }

  set addressVisible(bool value) {
    _addressVisible = value;
    update();
  }

  set pickupAddress(String value) {
    _pickupAddress = value;
    update();
  }

  set dropAddress(String value) {
    _dropAddress = value;
    update();
  }

  set startPoint(LatLng value) {
    _startPoint = value;
    update();
  }

  set endPoint(LatLng value) {
    _endPoint = value;
    update();
  }

  set drivers(List<String> value) {
    _drivers = value;
    update();
  }

  set inRide(bool value) {
    _inRide = value;
    update();
  }

  void getCurrentLocation() {
    showLoading();
    MapsRepo.instance.getCurrentLocation((position) async {
      _currentPosition = LatLng(position.latitude, position.longitude);
      setMapTheme();
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentPosition!,
            zoom: 15,
          ),
        ),
      );
      _startPoint = _currentPosition!;
      _pickupAddress = await MapsRepo.instance.getFormattedAddress(_startPoint);
      update();
      dismiss();
    });
  }

  void getPolyline() async {
    showLoading();
    _polylines.clear();
    _polylines = await MapsRepo.instance.getPolyline(startPoint, endPoint);

    if (_polylines.isNotEmpty) {
      addMarkers(startPoint, endPoint);
    }
  }

  void addMarkers(LatLng start, LatLng end) async {
    _markers.clear();
    _markers = await MapsRepo.instance.getMarkers(start, end);
    _distance = MapsRepo.instance.getDistance(start, end);
    _fare = MapsRepo.instance.calculateFare(_distance!);
    _duration = MapsRepo.instance.getDuration(start, end);
    _sheetVisible = true;
    update();
    Future.delayed(const Duration(milliseconds: 500), () {
      dismiss();
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            MapsRepo.instance.getCameraPosition(start, end)),
      );
    });
  }

  addDriver(String value) {
    _drivers.add(value);
    update();
  }

  removeDriver(int index) {
    _drivers.removeAt(index);
    update();
  }

  setMapTheme() => mapController.setMapStyle(MAPS_THEME);

  reset() {
    _markers.clear();
    _polylines.clear();
    _sheetVisible = false;
    _distance = null;
    _fare = null;
    _duration = null;
    _rideType = 0;
    update();
  }
}
