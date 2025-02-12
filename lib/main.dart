import 'package:flutter/material.dart';
import 'package:makemomentum/navigationscreen.dart';
import 'package:makemomentum/providers/habitProvider.dart';
import 'package:makemomentum/screens/homescreen/habitscreen.dart';
import 'package:makemomentum/widgets/NotificationHelper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      null, [
        NotificationChannel(
          channelKey: 'habit_channel',
          channelName: 'Habit Channel',
          channelDescription: 'Notifications for scheduled habits',
          //defaultColor: Color(0xFF9D50DD),
          defaultColor: Colors.transparent,
          ledColor: Color(0xFFD4BEE4),
          importance: NotificationImportance.High,
        ),
    NotificationChannel(
      channelKey: 'habit_reminder',
      channelName: 'Habit Reminders',
      channelDescription: 'Notifications for scheduled habits',
      //defaultColor: Colors.purple,
      defaultColor: Colors.transparent,
      importance: NotificationImportance.High,
    ),
      ]
  );
  // tz.initializeTimeZones();
  // tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  // await NotificationHelper.initialize();
  // await NotificationHelper.requestNotificationPermission();

  // Request notification permission here
  NotificationHelper().requestNotificationPermission();


  // AwesomeNotifications().createNotification(
  //   content: NotificationContent(
  //     id: 1,
  //     channelKey: 'habit_channel',
  //     title: 'Test Notification',
  //     body: 'This is a test notification!',
  //     notificationLayout: NotificationLayout.Default,
  //   ),
  // );

  runApp(
    ChangeNotifierProvider(
      create: (_) => HabitProvider()..loadHabits(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: navigationscreen(),
    );
  }
}
