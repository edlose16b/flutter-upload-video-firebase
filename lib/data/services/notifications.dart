import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:retofamosos/config/notifications.dart';

class LocalNotificationsService {
  void createNotification(int id, String title, String body, {String payload}) {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'progres-uploading-x',
      'Carga de video',
      'Carga de video',
      importance: Importance.High,
      autoCancel: true,
    );

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    NotificationsConfig.flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void createProgresiveNotification(
      int id, String title, String body, int progress,
      {String payload}) {
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'progres-uploading-x',
      'Carga de video',
      'Carga de video',
      importance: Importance.High,
      autoCancel: true,
      progress: progress,
      ongoing: true,
      showProgress: true,
      maxProgress: 100,
      playSound: false,
    );

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    NotificationsConfig.flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Carga de video a firebase',
    );
  }
}
