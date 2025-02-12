import 'package:flutter/material.dart';

class CustomFABLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double x = scaffoldGeometry.scaffoldSize.width * 0.26; // Adjust horizontal position
    final double y = scaffoldGeometry.scaffoldSize.height - 140.0; // Adjust vertical position
    return Offset(x, y);
  }
}