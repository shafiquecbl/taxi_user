// ignore_for_file: depend_on_referenced_packages, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taxi_user/helper/navigation.dart';
import 'package:taxi_user/utils/app_constants.dart';
import 'package:taxi_user/utils/style.dart';
import 'package:taxi_user/view/base/divider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressWidget extends StatefulWidget {
  final Function(LatLng start, LatLng end) onSelected;
  const AddressWidget({required this.onSelected, super.key});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  String _pickupAddress = '';
  String _dropoffAddress = '';
  LatLng _startPoint = const LatLng(37.7749, -122.4194);
  LatLng _endPoint = const LatLng(34.0522, -118.2437);

  @override
  Widget build(BuildContext context) {
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
                    _startPoint = LatLng(result.geometry!.location.lat,
                        result.geometry!.location.lng);
                  });
                  if (_pickupAddress.isNotEmpty && _dropoffAddress.isNotEmpty) {
                    widget.onSelected(_startPoint, _endPoint);
                  }
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
                    _endPoint = LatLng(result.geometry!.location.lat,
                        result.geometry!.location.lng);
                  });
                  if (_pickupAddress.isNotEmpty && _dropoffAddress.isNotEmpty) {
                    widget.onSelected(_startPoint, _endPoint);
                  }
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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
}
