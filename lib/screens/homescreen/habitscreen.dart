import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:makemomentum/screens/homescreen/habitTiles.dart';
import 'package:makemomentum/screens/homescreen/newHabitCreation.dart';
import 'package:makemomentum/widgets/customLinearProgressIndicator.dart';
import 'package:provider/provider.dart';
import 'package:wheel_picker/wheel_picker.dart';
import '../../widgets/NotificationHelper.dart';
import '../../models/habitsModel.dart';
import '../../providers/habitProvider.dart';
import '../../widgets/floatingActionButtonLocation.dart';
import '../../widgets/floatingActionButtonAnimation.dart';
import '../../widgets/timeSelecting.dart';
import 'package:google_fonts/google_fonts.dart';

class HabitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final today = DateTime.now().weekday%7;
    final todaysHabits=habitProvider.habits.where((habit){
      return habit.recurringDays.contains(today);
    }).toList();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(child: Text("Today's Habit's",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 30,color: Color(0xFF9B7EBD),fontWeight: FontWeight.bold)),)),
        //backgroundColor: Colors.transparent,
      ),
      body:Column(
        children: [
          customLinearProgressBarIndicator(progressValue: habitProvider.dailyScore/100,),
          Expanded(child: habitTiles(habits: todaysHabits,)),
        ],
      ), //habit loaders
      floatingActionButton: newHabitCreation(), //to create a new habit
      floatingActionButtonLocation: CustomFABLocation(), //for custom location
      floatingActionButtonAnimator: NoScalingFABAnimator(), //for slide up animation
    );
  }
}