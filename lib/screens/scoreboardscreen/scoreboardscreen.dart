import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makemomentum/providers/habitProvider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';


class scoreboardscreen extends StatelessWidget {
  const scoreboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Dashboard',style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 30,color: Color(0xFF9B7EBD),fontWeight: FontWeight.bold)),)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height*0.2,
                  width: MediaQuery.sizeOf(context).width*0.4,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0,-0.8),
                        child: Text("Streak",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
                        // Text("${habitProvider.streak}",style: TextStyle(color: Colors.white,fontSize: 70),),
                      ),
                      Align(
                        alignment: Alignment(0,0.3),
                        child: Text("${habitProvider.streak}",style: TextStyle(color: Colors.purple,fontSize: 80,fontWeight: FontWeight.bold),),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("Max Streak: ${habitProvider.maxStreak}",style: TextStyle(color: Colors.white70,fontSize: 20),),
                      )
                    ],
                  ),

                  decoration: BoxDecoration(
                      color: Colors.black,
                      // image: DecorationImage(
                      //     image: AssetImage('assets/images/background.png'),fit: BoxFit.cover
                      // ),
                      border: Border.all(
                        width: 2,
                        color: Color(0xFFD4BEE4),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF3B1E54),
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: Offset(4,6)
                        )
                      ]
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: MediaQuery.sizeOf(context).height*0.2,
                  width: MediaQuery.sizeOf(context).width*0.4,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(0,-0.8),
                        child: Text("Completed",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
                        // Text("${habitProvider.streak}",style: TextStyle(color: Colors.white,fontSize: 70),),
                      ),
                      Align(
                        alignment: Alignment(0,0.3),
                        child: Text("${habitProvider.totalNumberOfHabitsCompleted}",style: TextStyle(color: Colors.purple,fontSize: 80,fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),

                  decoration: BoxDecoration(
                      color: Colors.black,
                      // image: DecorationImage(
                      //     image: AssetImage('assets/images/background.png'),fit: BoxFit.cover
                      // ),
                      border: Border.all(
                        width: 2,
                        color: Color(0xFFD4BEE4),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF3B1E54),
                            spreadRadius: 1,
                            blurRadius: 0,
                            offset: Offset(4,6)
                        )
                      ]
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            Container(
              height: MediaQuery.sizeOf(context).height*0.18,
              width: MediaQuery.sizeOf(context).width*0.85,
              decoration: BoxDecoration(
                  color: Colors.black,
                  // image: DecorationImage(
                  //     image: AssetImage('assets/images/lightgreenbg.png'),fit: BoxFit.cover
                  // ),
                  border: Border.all(
                      width: 2,
                      color: Color(0xFFD4BEE4),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF3B1E54),
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(4,6)
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.8,0),
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 15.0,
                      animation: true,
                      percent: habitProvider.dailyScore/100,
                      center: new Text(
                        "${habitProvider.dailyScore}%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                      ),
                      // footer: new Text(
                      //   "Sales this week",
                      //   style:
                      //   new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      // ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressBorderColor: Color(0xFFD4BEE4),
                      backgroundColor: Color(0xFFD4BEE4),
                      progressColor: Color(0xFF3B1E54),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.8,0),
                    child: Text("Daily Score",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: MediaQuery.sizeOf(context).height*0.18,
              width: MediaQuery.sizeOf(context).width*0.85,
              decoration: BoxDecoration(
                  color: Colors.black,
                  // gradient: LinearGradient(
                  //   colors: [Color(0xFF3B1E54),Color(0xFFD4BEE4)],
                  //   stops: [0.5,1]
                  // ),
                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/background.png'),fit: BoxFit.cover
                  // ),
                  border: Border.all(
                      width: 2,
                      color: Color(0xFFD4BEE4),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFF3B1E54),
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(4,6)
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(-0.8,0),
                    child: CircularPercentIndicator(
                      radius: 60.0,
                      lineWidth: 15.0,
                      animation: true,
                      percent: habitProvider.totalScore/100,
                      center: new Text(
                        "${habitProvider.totalScore}%",
                        style:
                        new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0,color: Colors.white),
                      ),
                      // footer: new Text(
                      //   "Sales this week",
                      //   style:
                      //   new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                      // ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressBorderColor: Color(0xFFD4BEE4),
                      backgroundColor: Color(0xFFD4BEE4),
                      progressColor: Color(0xFF3B1E54),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0.8,0),
                    child: Text("Overall Score",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),


            SizedBox(height: 90,),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text('Daily Habit comp:${habitProvider.dailyHabitCompletedCounter}',style: TextStyle(fontSize: 30,color: Colors.white),),
            //     Text('Daily Score:${habitProvider.dailyScore}',style: TextStyle(fontSize: 30,color: Colors.white),),
            //     Text('Total Score:${habitProvider.totalScore}',style: TextStyle(fontSize: 30,color: Colors.white),),
            //     Text('Daily Habit Counter:${habitProvider.dailyHabitCounter}',style: TextStyle(fontSize: 30,color: Colors.white),),
            //     Text('Total Habit Counter:${habitProvider.totalHabitCounter}',style: TextStyle(fontSize: 30,color: Colors.white),),
            //     Text('Total Habit Complted:${habitProvider.totalHabitCompletedCounter}',style: TextStyle(fontSize: 30,color: Colors.white),)
            //   ],
            // ),
           ],
        ),
      )

    );
  }
}
