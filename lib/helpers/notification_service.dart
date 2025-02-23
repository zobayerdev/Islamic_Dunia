// import 'dart:math';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:intl/intl.dart';
// import 'package:mollie/helpers/di.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   NotificationService() {
//     tz.initializeTimeZones();
//     _loadStoredData();
//   }
// //load intial data
//   Map<int, bool> reminderStatuses = {};
//   Map<int, int> reminderNotificationCounts = {};

//   void _loadStoredData() {
//     // Load reminderStatuses from GetStorage
//     Map<String, dynamic> storedStatuses =
//         appData.read('reminderStatuses') ?? {};
//     reminderStatuses =
//         storedStatuses.map((key, value) => MapEntry(int.parse(key), value));

//     // Load reminderNotificationCounts from GetStorage
//     Map<String, dynamic> storedCounts =
//         appData.read('reminderNotificationCounts') ?? {};
//     reminderNotificationCounts =
//         storedCounts.map((key, value) => MapEntry(int.parse(key), value));
//   }

//   void _saveStatusesToStorage() {
//     appData.write('reminderStatuses',
//         reminderStatuses.map((key, value) => MapEntry(key.toString(), value)));
//   }

//   void _saveCountsToStorage() {
//     appData.write(
//         'reminderNotificationCounts',
//         reminderNotificationCounts
//             .map((key, value) => MapEntry(key.toString(), value)));
//   }

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/launcher_icon');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//     // await notificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()
//     //     ?.requestNotificationsPermission();
//     // await notificationsPlugin
//     //     .resolvePlatformSpecificImplementation<
//     //         AndroidFlutterLocalNotificationsPlugin>()
//     //     ?.requestExactAlarmsPermission();
//     // var alarmStatus = await Permission.scheduleExactAlarm.request();
//     // if (alarmStatus != PermissionStatus.granted) {
//     //   throw Exception("Exact alarms permission not granted");
//     // }
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'reminder_notifications', 'Reminders',
//             importance: Importance.max),
//         iOS: DarwinNotificationDetails());
//   }

//   // Future<void> showNotification(
//   //     {int id = 0, String? title, String? body, String? payLoad}) async {
//   //   return notificationsPlugin.show(
//   //       id, title, body, await notificationDetails());
//   // }

//   // Schedule daily notifications with a custom count and unique IDs
//   Future<void> scheduleNotifications(int reminderId, DateTime startTime,
//       DateTime endTime, int notificationCount) async {
//     var now = tz.TZDateTime.now(tz.local);
//     var start = tz.TZDateTime.from(startTime, tz.local);
//     var end = tz.TZDateTime.from(endTime, tz.local);

//     // Adjust start and end times if they are in the past
//     if (start.isBefore(now)) start = start.add(const Duration(days: 1));
//     if (end.isBefore(now)) end = end.add(const Duration(days: 1));

//     var totalDuration = end.difference(start);
//     var interval = totalDuration ~/
//         (notificationCount - 1); // Interval based on number of notifications
//     List<dynamic> storedQuotes = appData.read('quotes') ?? [];
//     if (storedQuotes.isEmpty) return;
//     for (int i = 0; i < notificationCount; i++) {
//       var scheduledTime = start.add(interval * i);
//       final randomQuote = storedQuotes[Random().nextInt(storedQuotes.length)];
//       await notificationsPlugin.zonedSchedule(
//         reminderId * 100 + i, // Unique ID for each notification
//         'money is', // Title of the notification
//         randomQuote['quote'], // Body of the notification
//         scheduledTime,
//         notificationDetails(),
//         // androidAllowWhileIdle: true,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//       );
//     }
//   } // Store the API response in local storage

//   void storeApiResponse(List<dynamic> apiResponse) {
//     appData.write('quotes', apiResponse);
//     // Save the data in GetStorage

//     //  print(appData.read('quotes') ?? []);
//   }

// //check notification status
//   Future<void> checkAndSyncNotifications(List<dynamic> reminders) async {
//     for (var reminder in reminders) {
//       int reminderId = reminder['id'];
//       String status = reminder['status'];
//       int howMany = reminder['how_many'];
//       // DateTime startTime = DateTime.parse(    reminder['start_time']);

//       // //   reminder['start_time'];
//       // //DateTime.parse(reminder['start_time']);
//       // DateTime endTime = DateTime.parse(reminder['end_time']);

//       String startTimeString = reminder['start_time'];
//       String endTimeString = reminder['end_time'];

//       //DateTime now = DateTime.now(); // Get the current date

// // Parse the start_time by combining with today's date
//       DateTime startTime = DateFormat.Hm().parse(startTimeString);

//       DateTime endTime = DateFormat.Hm().parse(endTimeString);

//       // String formattedStartTime = DateFormat.Hm().format(startTime);
//       // String formattedEndTime = DateFormat.Hm().format(endTime);

//       // print("Start Time: $formattedStartTime, End Time: $formattedEndTime");
//       // Check the stored status
//       String storedStatus = appData.read(reminderId.toString()) ?? 'inactive';

//       if (storedStatus != status) {
//         toggleNotification(
//           reminderId,
//           status == 'active',
//           startTime,
//           endTime,
//           howMany,
//         );
//         // Update the stored status
//         appData.write(reminderId.toString(), status);
//       }
//     }
//   }

//   // Cancel specific notifications by reminder ID
//   Future<void> cancelReminderNotifications(
//       int reminderId, int notificationCount) async {
//     for (int i = 0; i < notificationCount; i++) {
//       await notificationsPlugin.cancel(reminderId * 100 + i);
//     }
//     reminderStatuses.remove(reminderId);
//     reminderNotificationCounts.remove(reminderId);
//     appData.remove(reminderId.toString());
//     _saveStatusesToStorage();
//     _saveCountsToStorage();
//   }

//   // Toggle notification scheduling based on the user's preference
//   // Map<int, bool> reminderStatuses = {};
//   // Map<int, int> reminderNotificationCounts =
//   //     {}; // To store the number of notifications for each reminder

//   void toggleNotification(int reminderId, bool isEnabled, DateTime startTime,
//       DateTime endTime, int notificationCount) {
//     if (isEnabled) {
//       reminderStatuses[reminderId] = true;
//       reminderNotificationCounts[reminderId] = notificationCount;
//       scheduleNotifications(reminderId, startTime, endTime, notificationCount);
//     } else {
//       reminderStatuses[reminderId] = false;
//       cancelReminderNotifications(
//           reminderId, reminderNotificationCounts[reminderId] ?? 0);
//     } // Save the updated status and counts to GetStorage
//     _saveStatusesToStorage();
//     _saveCountsToStorage();
//   }

//   Future<void> cancelAllNotifications() async {
//     await notificationsPlugin.cancelAll(); // Cancel all notifications
//     reminderStatuses.clear(); // Clear the local statuses
//     reminderNotificationCounts.clear(); // Clear the local notification counts
//     appData.remove('reminderStatuses'); // Remove from GetStorage
//     appData.remove('reminderNotificationCounts'); // Remove from GetStorage
//   }
// }
