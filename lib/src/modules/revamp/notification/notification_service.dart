// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_helper.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/routes_top.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String audioFilename = 'posbeep';

  static final _socketUrl =
      ApiConfig.shared.flavor == ApiFlavor.dev
          ? 'http://62.169.24.139:6001'
          : 'https://wss.slsbank.com';

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
          //
        }
      },
    );
    await _ensureInwardChannel();

    // Initialize and connect to Socket.IO server
    socketio.Socket socket = socketio.io(
      _socketUrl,
      socketio.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.onConnect((_) {
      socket.emit('subscribe', {'channel': 'rexmfb-channel'});
    });

    socket.on('inward-notification', (data) async {
      final acctNumber = await AppSecureStorage().getPosNuban();

      if (data is List && data.length >= 2) {
        final eventPayload = data[1];
        if (eventPayload is Map<String, dynamic>) {
          final transaction = eventPayload['transaction'];
          final transferData = eventPayload['transferData'];
          final num = transaction['accountNo'];
          final tData = InTransferData.fromJson(transferData);
          if (num == acctNumber) {
            _showNotification(
              title: "Payment Received",
              body: bodyOfPushNotif(tData),
              data: tData,
            );
          }
        }
      }
    });

    socket.onDisconnect((_) {});
    socket.onConnectError((data) {});
    socket.onError((data) {});
    socket.connect();
  }

  static Future<void> _ensureInwardChannel() async {
    const channel = AndroidNotificationChannel(
      'rexmfb_inward',
      'Inward Transfers',
      description: 'Alerts for credit hits',
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(audioFilename),
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
      sound: RawResourceAndroidNotificationSound(audioFilename),
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
