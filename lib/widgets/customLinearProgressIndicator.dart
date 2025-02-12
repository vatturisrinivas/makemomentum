import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/habitProvider.dart';
class customLinearProgressBarIndicator extends StatelessWidget {
  final double progressValue;
  const customLinearProgressBarIndicator({required this.progressValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white, // Background color to make it stand out
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background line
          Container(
            height: 8.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFF3B1E54),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          // Progress bar
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            height: 16.0,
            width: MediaQuery.of(context).size.width * progressValue, // Example progress
            decoration: BoxDecoration(
              color: Color(0xFF9B7EBD),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
