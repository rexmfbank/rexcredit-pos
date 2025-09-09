// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/utils/config/notification/notification_helper.dart';
import 'package:rex_app/src/modules/revamp/utils/config/notification/notification_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rex_app/src/modules/revamp/utils/config/secure_storage.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PusherChannelsFlutter pusher =
      PusherChannelsFlutter.getInstance();

  static final _apiKey =
      ApiConfig.shared.flavor == ApiFlavor.dev
          ? 'f3c0069a2d675f6e82bd'
          : '1ce6e43339a247893393';

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        try {
          final raw = response.payload;
          if (raw == null || raw.isEmpty) {
            return;
          }
          final data = InTransferData.fromJson(
            jsonDecode(raw) as Map<String, dynamic>,
          );
          final pos = modelNotiftoUIModel(data);
          rexGoRouter.push(Routes.quickTransactionDetail, extra: pos);
        } catch (e) {
          debugPrint('Navigation on notification tap failed: $e');
        }
      },
    );
    await _ensureInwardChannel();

    await pusher.init(apiKey: _apiKey, cluster: "eu");

    await pusher.subscribe(
      channelName: "rexmfb-channel",
      onSubscriptionError: (v1, v2) {},
      onEvent: (event) async {
        final acctNumber = await SecureStorage().getPosNuban();
        if (event.eventName == "inward-notification") {
          final eventData = jsonDecode(event.data);
          final num = eventData['transaction']['accountNo'];
          final transferData = InTransferData.fromJson(
            eventData['transferData'],
          );

          if (num == acctNumber) {
            debugPrint("TRANSFER DATA: ${transferData.toJson()}");
            _showNotification(
              title: "Payment Received",
              body: bodyOfPushNotif(transferData),
              data: transferData,
            );
          }
        }
      },
    );

    await pusher.connect();
  }

  static Future<void> _ensureInwardChannel() async {
    const channel = AndroidNotificationChannel(
      'rexmfb_inward',
      'Inward Transfers',
      description: 'Alerts for credit hits',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('posbeep'),
      audioAttributesUsage: AudioAttributesUsage.notification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _showNotification({
    required String title,
    required String body,
    required InTransferData data,
  }) async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'rexmfb_inward',
      'Inward Transfers',
      importance: Importance.high,
      priority: Priority.high,
      groupKey: 'rexmfb',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('posbeep'),
    );
    const NotificationDetails details = NotificationDetails(android: android);

    final id = DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      details,
      payload: jsonEncode(data.toJson()),
    );

    final context = rootNavKey.currentState?.overlay?.context;
    if (context != null) {
      showNotificationModalSheet(context: context, data: data);
    }
  }
}
