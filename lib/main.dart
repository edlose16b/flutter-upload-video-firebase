import 'package:flutter/material.dart';
import 'package:retofamosos/config/firebase.dart';
import 'package:retofamosos/config/notifications.dart';
import 'package:retofamosos/ui/screens/home/home.dart';
import 'package:retofamosos/ui/themes.dart';

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FireBaseConfig.init();
  NotificationsConfig.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Famosos',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: HomeScreen(),
    );
  }
}
