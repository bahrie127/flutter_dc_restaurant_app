import 'dart:isolate';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dicoding_restaurant_app/common/utils/notification_utils.dart';
import 'package:flutter_dicoding_restaurant_app/data/restaurant_service.dart';

final ReceivePort port = ReceivePort();

class BackgroundServiceUtils {
  static BackgroundServiceUtils? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundServiceUtils._createObject();

  factory BackgroundServiceUtils() {
    _service ??= BackgroundServiceUtils._createObject();
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    debugPrint('Alarm callback');

    final NotificationsUtils notificationsUtils = NotificationsUtils();
    var result = await RestaurantService().getListRestaurant();
    await notificationsUtils.showNotification(
        flutterLocalNotificationsPlugin, result.restaurants!);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}
