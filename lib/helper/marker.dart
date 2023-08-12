// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getMarkerImageFromUrl(
  String url, {
  int targetWidth = 100,
}) async {
  final File markerImageFile = await DefaultCacheManager().getSingleFile(url);
  return convertImageFileToBitmapDescriptor(markerImageFile, size: targetWidth);
}

Future<BitmapDescriptor> convertImageFileToBitmapDescriptor(File imageFile,
    {int size = 100,
    bool addBorder = false,
    Color borderColor = Colors.white,
    double borderSize = 10,
    Color titleColor = Colors.transparent,
    Color titleBackgroundColor = Colors.transparent}) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  //make canvas clip path to prevent image drawing over the circle
  final Path clipPath = Path();
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      const Radius.circular(100)));
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(size / 2.toDouble(), size + 20.toDouble(), 10, 10),
      const Radius.circular(100)));
  canvas.clipPath(clipPath);

  //paintImage
  final Uint8List imageUint8List = await imageFile.readAsBytes();
  final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
  final ui.FrameInfo imageFI = await codec.getNextFrame();
  paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      image: imageFI.image);

  //convert canvas as PNG bytes
  final image =
      await pictureRecorder.endRecording().toImage(size, (size * 1.1).toInt());
  final data = await image.toByteData(format: ui.ImageByteFormat.png);

  //convert PNG bytes as BitmapDescriptor
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
