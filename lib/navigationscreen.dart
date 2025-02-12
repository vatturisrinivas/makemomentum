import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:makemomentum/screens/challengesscreen/allHabits.dart';
import 'package:makemomentum/screens/homescreen/habitscreen.dart';
import 'package:makemomentum/screens/scoreboardscreen/scoreboardscreen.dart';


class navigationscreen extends StatefulWidget {
  const navigationscreen({super.key});

  @override
  State<navigationscreen> createState() => _navigationscreenState();
}

class _navigationscreenState extends State<navigationscreen> {

  int _selectedindex=1;

  PageController _pageController =PageController(initialPage: 1);

  // late PageController _pageController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(initialPage: _selectedindex);
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onpagechanged(int index){
    setState(() {
      _selectedindex=index;
    });
  }

  void onbottomnavtapped(int index){
    _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  List<Widget> screens=<Widget>[
    challengescreen(),
    HabitScreen(),
    scoreboardscreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: PageView(
          controller: _pageController,
          onPageChanged: onpagechanged,
          children: screens,
        ),
      //screens[_selectedindex],
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Color(0xFF3B1E54),
        behaviour: SnakeBarBehaviour.floating,
        height: 60,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
        ),
        padding: EdgeInsets.only(left: 70,right: 70,bottom: 10),
        snakeViewColor: Color(0xFFD4BEE4),
        selectedItemColor: Color(0xFF3B1E54),
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        currentIndex: _selectedindex,
        onTap: onbottomnavtapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month,size: 25,),label: "All Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled,size: 25,),label: "Todays Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart,size: 25,),label: "Dashboard"),
        ],
      ),
    );
  }
}
