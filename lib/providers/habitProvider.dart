import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:makemomentum/widgets/NotificationHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/habitsModel.dart';

class HabitProvider with ChangeNotifier{
  List<Habit> _habits=[];
  int _dailyHabitCompletedCounter = 0; // Track the daily score
  int _dailyHabitCounter = 0;
  int _dailyScore=0;
  int _totalHabitCounter=0;
  int _totalHabitCompletedCounter=0;
  int _totalScore = 0; // Track the total score
  int _streak=0;
  int _maxStreak=0;
  int _totalNumberOfHabitsCompleted=0;
  int _previousDayTotalHabitCounter = 0; // Total habits available on previous days
  int _previousDayHabitsCompleted = 0; // Total completed habits from previous days
  DateTime? _lastCompletionDate;


  List<Habit> get habits => _habits;
  int get dailyHabitCounter => _dailyHabitCounter;
  int get dailyHabitCompletedCounter => _dailyHabitCompletedCounter;
  int get dailyScore=> _dailyScore;
  int get totalScore => _totalScore;
  int get totalHabitCounter=> _totalHabitCounter;
  int get totalHabitCompletedCounter=> _totalHabitCompletedCounter;
  int get streak=>_streak;
  int get maxStreak=>_maxStreak;
  int get totalNumberOfHabitsCompleted=>_totalNumberOfHabitsCompleted;
  int get previousDayTotalHabitCounter=>_previousDayTotalHabitCounter = 0; // Total habits available on previous days
  int get previousDayHabitsCompleted=>_previousDayHabitsCompleted = 0; // Total completed habits from previous days
  bool _isInitialized = false;



  HabitProvider() {
    loadHabits().then((_) {
      //completeScoreReset();
      calculateCounters(); // Ensure counters are calculated after loading
      //calculateTotalCounter();
      resetAtMidnight();       // Setup midnight reset AFTER loading
      loadStreak();
    });
  }


  void addHabit(Habit habit) {
    _habits.add(habit);
    NotificationHelper.scheduleNotification(habit);
    saveHabits();
    //final today = DateTime.now().weekday % 7; // Adjust for 0-based index
    // if (habit.recurringDays.contains(today)) {
    //   _dailyHabitCounter++;
    //   _totalHabitCounter++;
    //
    // }
    calculateCounters(); // Recalculate the daily habit counter
    //calculateCountersOnHabitAdd();
    scoreCalculate();
    saveScore(); // Save updated scores
    notifyListeners();
  }


  // toggling by index


  // void toggleHabit(int index){
  //   _habits[index].isCompleted=!_habits[index].isCompleted;
  //   if(_habits[index].isCompleted){
  //     _dailyHabitCompletedCounter++;
  //     _totalHabitCompletedCounter++;
  //     _totalNumberOfHabitsCompleted++;
  //   }
  //   else{
  //     _dailyHabitCompletedCounter= _dailyHabitCompletedCounter>0? _dailyHabitCompletedCounter-1:0;
  //     _totalHabitCompletedCounter=_totalHabitCompletedCounter>0?_totalHabitCompletedCounter-1:0;
  //     _totalNumberOfHabitsCompleted=_totalNumberOfHabitsCompleted>0?_totalNumberOfHabitsCompleted-1:0;
  //   }
  //   saveHabits();
  //   scoreCalculate();
  //   saveScore();
  //   notifyListeners();
  // }

  //toggling by title

  void toggleHabitCompletion(String title) {
    final habit = _habits.firstWhere((habit) => habit.title == title);
    habit.isCompleted = !habit.isCompleted; // Toggle the completion status
    if(habit.isCompleted){
      _dailyHabitCompletedCounter++;
      _totalHabitCompletedCounter++;
      _totalNumberOfHabitsCompleted++;
    }
    else{
      _dailyHabitCompletedCounter= _dailyHabitCompletedCounter>0? _dailyHabitCompletedCounter-1:0;
      _totalHabitCompletedCounter=_totalHabitCompletedCounter>0?_totalHabitCompletedCounter-1:0;
      _totalNumberOfHabitsCompleted=_totalNumberOfHabitsCompleted>0?_totalNumberOfHabitsCompleted-1:0;
    }
    saveHabits();
    scoreCalculate();
    saveScore();
    notifyListeners(); // Notify listeners to update the UI
  }




  void scoreCalculate(){
    calculateCounters();
    _dailyScore = (dailyHabitCounter > 0) ? ((dailyHabitCompletedCounter / dailyHabitCounter)*100).toInt() : 0;
    _totalScore=(totalHabitCounter>0)?((totalHabitCompletedCounter/totalHabitCounter)*100).toInt():0;
    notifyListeners();
  }



  Future<void> saveScore() async{
    try{
      SharedPreferences pref= await SharedPreferences.getInstance();
      pref.setInt('dailyHabitCompletedCounter', _dailyHabitCompletedCounter);
      pref.setInt('dailyScore', _dailyScore);
      pref.setInt('totalScore', _totalScore);
      pref.setInt('totalHabitCompletedCounter', _totalHabitCompletedCounter);
      pref.setInt('totalHabitCounter', _totalHabitCounter);
      pref.setInt('totalNumberOfHabitsCompleted', _totalNumberOfHabitsCompleted);
      pref.setInt('previousDayTotalHabitCounter', _previousDayTotalHabitCounter);
    }
    catch(e){
      print('error saving scores: $e');
    }
  }


  //to calculate daily counter and total counter

  void calculateCounters() {
    final today = DateTime.now().weekday%7; // Current day (1 = Monday, ..., 7 = Sunday)

    _dailyHabitCounter = _habits.where((habit) {
      return habit.recurringDays.contains(today); // Match current day (adjusted to 0-based index)
    }).length;

    _totalHabitCounter=_dailyHabitCounter+_previousDayTotalHabitCounter;

    notifyListeners();
  }


  // void calculateCountersOnHabitAdd(){
  //   final today = DateTime.now().weekday%7;
  //   _dailyHabitCounter = _habits.where((habit) {
  //     return habit.recurringDays.contains(today); // Match current day (adjusted to 0-based index)
  //   }).length;
  //
  //   _totalHabitCounter++;
  //
  //   notifyListeners();
  // }
  // void calculateCountersOnHabitDelete(){
  //   final today = DateTime.now().weekday%7;
  //   _dailyHabitCounter = _habits.where((habit) {
  //     return habit.recurringDays.contains(today); // Match current day (adjusted to 0-based index)
  //   }).length;
  //
  //   _totalHabitCounter=_dailyHabitCounter+_previousDayTotalHabits;
  // }



  // void calculateTotalCounter(){
  //   _totalHabitCounter+=_dailyHabitCompletedCounter;
  // }

  // Future<void> loadScores() async{
  //   try{
  //     SharedPreferences pref =await SharedPreferences.getInstance();
  //     _dailyScore = pref.getInt('dailyScore')??0;
  //     _totalScore = pref.getInt('totalScore')??0;
  //   }
  //   catch(e){
  //     print('error loading scores: $e');
  //   }
  // }

  Future<void> loadHabits() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? habitData = pref.getString('habits');
      if (habitData != null) {
        List<dynamic> decodedData = jsonDecode(habitData);
        _habits = decodedData
            .map((data) => Habit.fromJson(data as Map<String, dynamic>))
            .toList();
      }

      // Load scores
      _dailyHabitCompletedCounter = pref.getInt('dailyHabitCompletedCounter') ?? 0;
      _totalScore = pref.getInt('totalScore') ?? 0;
      _dailyScore = pref.getInt('dailyScore') ?? 0;
      _totalNumberOfHabitsCompleted=pref.getInt('totalNumberOfHabitsCompleted')??0;

      _totalHabitCompletedCounter=pref.getInt('totalHabitCompletedCounter')??0;
      _totalHabitCounter=pref.getInt('totalHabitCounter')??0;
      _previousDayTotalHabitCounter=pref.getInt('previousDayTotalHabitCounter')??0;


      bool _isInitialized = true;

      //completeScoreReset();

      notifyListeners(); // Ensure this is always called
    } catch (e) {
      print('Error loading habits: $e');
    }
  }


  Future<void> saveHabits() async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    String habitData=json.encode(_habits.map((habit)=>habit.toJson()).toList());
    pref.setString('habits', habitData);
  }


  //to delete habit by index

  // void deleteHabit(int index) {
  //   final habit = _habits[index]; // Get the habit to delete
  //   NotificationHelper.cancelHabitNotifications(habit); // Cancel its notifications
  //   _habits.removeAt(index); // Remove the habit from the list
  //   saveHabits(); // Save updated list
  //   calculateDailyCounter();
  //   saveScore();
  //   notifyListeners(); // Notify the UI
  // }



  //to delete by habit by title


  void deleteByTitle(String title){
    //_habits.removeWhere((habit)=>habit.title==title);
    final today = DateTime.now().weekday % 7;

    final habitIndex = _habits.indexWhere((habit) => habit.title == title);
    final habit = _habits[habitIndex]; // Get the habit to delete

    if(habit.isCompleted==true){
      _dailyHabitCompletedCounter--;
      _totalHabitCompletedCounter--;
      notifyListeners();
    }
    // if (habit.recurringDays.contains(today)) {
    //   _totalHabitCounter = _totalHabitCounter > 0 ? _totalHabitCounter - 1 : 0;
    //   _dailyHabitCounter = _dailyHabitCounter > 0 ? _dailyHabitCounter - 1 : 0;
    // }

    NotificationHelper.cancelHabitNotifications(habit); // Cancel its notifications
    _habits.removeAt(habitIndex); // Remove the habit from the list
    saveHabits(); // Save updated list
    calculateCounters(); // Recalculate daily counter
    //calculateCountersOnHabitDelete();
    scoreCalculate();
    saveScore(); // Save updated score
    notifyListeners(); // Notify the UI
  }


  bool areAllHabitsCompletedForToday(){
    final today=DateTime.now().weekday%7;
    return _habits
        .where((habit)=>habit.recurringDays.contains(today))
        .every((habit)=>habit.isCompleted);
  }


  void updateStreak(){
    final today=DateTime.now();
    if(areAllHabitsCompletedForToday()){
      if(_lastCompletionDate==null || today.difference(_lastCompletionDate!).inDays==1){
        _streak++;
        if(_streak>_maxStreak){
          _maxStreak=_streak;
        }
      }
      else if(_lastCompletionDate==null || today.difference(_lastCompletionDate!).inDays>1){
        _streak=1;
      }
      _lastCompletionDate=today;
    }
    else{
      _streak=0;
      _lastCompletionDate=today;
    }

    saveStreak();
    notifyListeners();
  }


  Future<void> saveStreak()async{
    SharedPreferences pref= await SharedPreferences.getInstance();
    pref.setInt('streak', _streak);
    pref.setInt('maxStreak', _maxStreak);
    pref.setString('lastCompletionDate', _lastCompletionDate?.toIso8601String() ?? '');
  }

  Future<void> loadStreak() async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    _streak=pref.getInt('streak')?? 0;
    _maxStreak=pref.getInt('maxStreak')?? 0;
    String? dateString=pref.getString('lastCompletionDate');
    if(dateString!=null&&dateString.isNotEmpty){
      _lastCompletionDate=DateTime.parse(dateString);
    }
  }


  void resetDailyData() {
    if(!_isInitialized) return;
    _dailyScore=0;
    _dailyHabitCompletedCounter = 0;
    _previousDayTotalHabitCounter += _dailyHabitCounter;
    _dailyHabitCounter = 0;

    //_previousDayHabitsCompleted += _habits.where((habit) => habit.isCompleted).length;

    // Reset all habits for the new day
    for (final habit in _habits) {
      habit.isCompleted = false;
      saveHabits();
      notifyListeners();
    }

    saveScore(); // Save updated state
    saveHabits();
    notifyListeners();
  }


  //uses a timer to reset the habits for next day


  void resetAtMidnight(){
    final now= DateTime.now();
    final midnight= DateTime(now.year,now.month,now.day+1);

    Timer(midnight.difference(now),(){
      updateStreak();
      resetDailyData();
      calculateCounters();
      //calculateTotalCounter();
      resetAtMidnight();
    });
  }


  //for manual data delete used for testing

  void completeScoreReset()async{
    _dailyHabitCompletedCounter=0;
    _totalScore=0;
    _totalNumberOfHabitsCompleted=0;
    _totalHabitCounter=0;
    _dailyScore=0;

    notifyListeners();

    try{
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt('dailyHabitCompletedCounter', _dailyHabitCompletedCounter);
      pref.setInt('dailyScore', _dailyScore);
      pref.setInt('totalScore', _totalScore);
      pref.setInt('totalHabitCompletedCounter', _totalHabitCompletedCounter);
      pref.setInt('totalHabitCounter', _totalHabitCounter);
      //notifyListeners();
    }
    catch(e){
      print('error reseting the score: $e');
    }
  }
}