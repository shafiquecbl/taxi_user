import 'package:flutter/material.dart';
import 'package:taxi_user/common/buttons.dart';
import 'package:taxi_user/common/network_image.dart';

class ViewImage extends StatelessWidget {
  final String image;
  const ViewImage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: double.infinity,
          child: Hero(
            tag: image,
            child: InteractiveViewer(
                clipBehavior: Clip.none,
                panEnabled: true,
                child: CustomNetworkImage(url: image, fit: BoxFit.contain)),
          ),
        ),
      ),
    );
  }
}
