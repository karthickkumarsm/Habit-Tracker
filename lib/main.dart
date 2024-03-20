import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'notification_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //init the database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  await AwesomeNotifications().initialize(
    // "resource://assets/notification.ico"
    null, [
    NotificationChannel(
      channelGroupKey: "1",
        channelName: "HabitTracker",
        channelKey: "HabitTrackerApp",
        channelDescription: "Habit Tracking app",
        ),
  ],
  channelGroups: [
    NotificationChannelGroup(channelGroupKey: "1", channelGroupName: "HabitTracker"),
  ]
  );
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  String localTimeZone = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
  content: NotificationContent(
      id: 1,
      channelKey: 'HabitTrackerApp',
      title: '!!!--REMAINDER--!!!',
      body: 'Have you recorded your record track today?',
      wakeUpScreen: true,
      category: NotificationCategory.Message,
  ),
  schedule: NotificationInterval(
      interval: 21600,
      repeats: true,
      allowWhileIdle: true,
      timeZone: localTimeZone,
  )
  );

  runApp(MultiProvider(
    providers: [
      //habit provider
      ChangeNotifierProvider(create: (context) => HabitDatabase()),

      //theme provider
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
     AwesomeNotifications().setListeners(
        onActionReceivedMethod:NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:NotificationController.onDismissActionReceivedMethod
    );
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      title: "HabitTracker",
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
