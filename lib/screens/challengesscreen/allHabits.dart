import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makemomentum/screens/homescreen/habitTiles.dart';
import 'package:provider/provider.dart';

import '../../providers/habitProvider.dart';
class challengescreen extends StatelessWidget {
  const challengescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Habit's Library",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 30,color: Color(0xFF9B7EBD),fontWeight: FontWeight.bold)),)),
        backgroundColor: Colors.transparent,
      ),
      //backgroundColor: Color(0xFFF8FAED),
      backgroundColor: Colors.black,
      body: habitTiles(habits: habitProvider.habits,)
    );
  }
}
