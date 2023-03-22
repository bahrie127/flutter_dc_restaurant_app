import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_model.dart';
import 'package:flutter_dicoding_restaurant_app/ui/pages/detail_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

final random = Random().nextInt(20);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationsUtils {
  static NotificationsUtils? _notificationsUtils;

  NotificationsUtils._internal() {
    _notificationsUtils = this;
  }

  factory NotificationsUtils() =>
      _notificationsUtils ?? NotificationsUtils._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSetting = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload == null) {
          debugPrint('notification payload: ${notificationResponse.payload}');
        }
        selectNotificationSubject
            .add(notificationResponse.payload ?? 'payload kosong');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<Restaurant> restaurants) async {
    var channelId = '1';
    var channelName = 'channel_1';
    var channelDesc = 'Restaurant App';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var titleNotifications = '<b>Good Restaurant </b>';
    var titleRestaurant = restaurants[random].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotifications,
      titleRestaurant,
      platformChannelSpecifics,
      payload: jsonEncode(
        {'number': random, 'data': restaurants[random].toJson()},
      ),
    );
  }

  void configureSelectedNotificationSubject(BuildContext context) async {
    selectNotificationSubject.stream.listen(
      (String payload) {
        var data = Restaurant.fromJson(json.decode(payload)['data']);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailPage(restaurant: data);
        }));
      },
    );
  }
}
