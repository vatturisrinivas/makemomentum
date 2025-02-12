import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../providers/habitProvider.dart';
import '../../widgets/customLinearProgressIndicator.dart';

class habitTiles extends StatelessWidget {

  final List habits; // accepts habits as parameters
  habitTiles({required this.habits});

  List colors=[
    "assets/images/orangebg.png",
    "assets/images/lightgreenbg.png",
    "assets/images/pinkbg.png",
    "assets/images/purplebg.png",
    "assets/images/greenbg.png",
  ];

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (ctx, index) {
        final habit = habits[index];
        return Dismissible(      //dismissible is used to delete the habit
          key: ValueKey(habit.title),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Color(0xFF3B1E54),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            habitProvider.deleteByTitle(habit.title);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 25,left: 25,top: 15,bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF3B1E54),
                        spreadRadius: 2,
                        blurRadius: 0,
                        offset: Offset(5,5)
                    )
                  ],
                  image: DecorationImage(
                      image: AssetImage(colors[index%5]),fit: BoxFit.cover
                  )
              ),
              child: ListTile(
                //leading: FaIcon(FontAwesomeIcons.),
                title: Text(habit.title,style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)) ,),
                subtitle: Text(
                  'Time: ${habit.scheduledTime.hour.toString().padLeft(2, '0')}:${habit.scheduledTime.minute.toString().padLeft(2, '0')}'
                      '\nDays: ${habit.recurringDays.map((day) => ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][day]).join(', ')}',style: TextStyle(fontWeight: FontWeight.bold,),
                ),
                trailing: IconButton(
                  icon: Icon(
                    habit.isCompleted ? Icons.check_circle : Icons.circle_outlined,size: 30,
                  ),
                  onPressed: () {
                    habitProvider.toggleHabitCompletion(habit.title);
                    //habitProvider.saveScore();
                  },
                ),
              ),
            ),
          ),
        );
      },
      padding: EdgeInsets.only(bottom: 150), // Add extra space at the bottom
    );
  }
}
