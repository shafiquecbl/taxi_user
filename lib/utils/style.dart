// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

EdgeInsets pagePadding =
    const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 15);

// font weight
const FontWeight fontWeightNormal = FontWeight.w500;
const FontWeight fontWeightSemiBold = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.w700;

// radius
const double radius = 2.5;

// get pixels with media query
double getPixels(BuildContext context, double pixels) =>
    MediaQuery.of(context).size.width * (pixels / 375);

double responsiveSize(BuildContext context, double sizeInPixels) {
  double screenWidth = MediaQuery.of(context).size.width;

  // Define your breakpoints here
  const double smallScreenWidth = 320;
  const double mediumScreenWidth = 375;
  const double largeScreenWidth = 414;

  // Adjust your sizes according to your breakpoints
  if (screenWidth < smallScreenWidth) {
    return sizeInPixels * 0.8;
  } else if (screenWidth < mediumScreenWidth) {
    return sizeInPixels;
  } else if (screenWidth < largeScreenWidth) {
    return sizeInPixels * 1.2;
  } else {
    return sizeInPixels * 1.5;
  }
}
