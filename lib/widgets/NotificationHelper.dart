import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:makemomentum/models/habitsModel.dart';
import 'package:makemomentum/widgets/motivationalQuotes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


// class NotificationHelper{
//
//   static void scheduleNotification(Habit habit){
//     AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: habit.scheduledTime.hashCode,
//           channelKey: 'habit_channel',
//           title: 'Habit Remainder: ${habit.title}',
//           body: 'stay on track!',
//           notificationLayout: NotificationLayout.Default
//         ),
//       schedule: NotificationCalendar.fromDate(date: habit.scheduledTime),
//     );
//   }
//
//
//   // static void requestPermission() {
//   //   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//   //     if (!isAllowed) {
//   //       AwesomeNotifications().requestPermissionToSendNotifications();
//   //     }
//   //   });
//   // }
//   // Future<void> requestNotificationPermission() async {
//   //   bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//   //   if (!isAllowed) {
//   //     // Request the user to enable notifications
//   //     await AwesomeNotifications().requestPermissionToSendNotifications();
//   //   }
//   // }
//   // Future<void> checkNotificationPermission() async {
//   //   bool hasPermission = await AwesomeNotifications().requestPermissionToSendNotifications();
//   //   if (!hasPermission) {
//   //     // Handle case where permission is denied
//   //     print("Notification permission is denied.");
//   //   }
//   // }
//   Future<void> requestNotificationPermission() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       // Request permission to send notifications
//       bool permissionGranted = await AwesomeNotifications().requestPermissionToSendNotifications();
//       if (!permissionGranted) {
//         print("Notification permission is denied.");
//       }
//     }
//   }
//
//
// }

class NotificationHelper {
  Future<void> requestNotificationPermission() async {
    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static Future<void> scheduleNotification(Habit habit) async {
    for (int day in habit.recurringDays) {
      final int notificationId = habit.scheduledTime.hashCode + day; // Unique ID per habit per day
      // Adjust day mapping: 0 (Sun) becomes 7, others increment by 1
      int notificationWeekday = (day == 0) ? 7 : day;
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'habit_channel',
          //title: 'Habit Channel',
          title: habit.title,
          color: CupertinoColors.black,

          //body: 'Time to complete: ${habit.title}',
          body: randomQuote,
          backgroundColor: Color(0xFF3B1E54),
          // bigPicture: 'asset://assets/images/purplebg.png',
          // notificationLayout: NotificationLayout.MediaPlayer,
          notificationLayout: NotificationLayout.BigText,
        ),
        schedule: NotificationCalendar(
          weekday: notificationWeekday, // AwesomeNotifications uses 1-7 for Mon-Sun
          hour: habit.scheduledTime.hour,
          minute: habit.scheduledTime.minute,
          repeats: true,
        ),
      );
    }
  }


  static Future<void> cancelHabitNotifications(Habit habit) async {
    for (int day in habit.recurringDays) {
      // Generate a consistent notification ID based on the habit
      final int notificationId = habit.scheduledTime.hashCode + day;
      await AwesomeNotifications().cancel(notificationId);
    }
  }
}