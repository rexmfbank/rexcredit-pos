import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_helper.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/routes_top.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class NotificationService2 {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
    _ensureInwardChannel();
    //SocketService.initSocket();
    socketio.Socket socket = socketio.io(
      'https://31c2baacd5c2.ngrok-free.app',
      socketio.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // Handle connection
    socket.onConnect((_) {
      debugPrint("✅ Connected to Socket.IO server: ${socket.id}");
    });

    // Subscribe to channel (Echo uses naming: `channel:event`)
    socket.on("rexmfb-channel:.inward-notification", (data) {
      debugPrint("📩 Event received: $data");
    });

    // Handle disconnect
    socket.onDisconnect((_) {
      debugPrint("❌ Disconnected from Socket.IO server");
    });

    // Finally connect
    socket.connect();
    //
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
}

/*class SocketService {
  static late socketio.Socket socket;

  static void initSocket() {
    // Connect to your Laravel Echo Server (Lighthouse / Echo server running at 6001)
    socket = socketio.io(
      'https://31c2baacd5c2.ngrok-free.app',
      socketio.OptionBuilder()
          .setTransports(['websocket']) // Use WebSocket only
          .disableAutoConnect() // Disable auto-connection, call connect() manually
          .build(),
    );

    // Handle connection
    socket.onConnect((_) {
      debugPrint("✅ Connected to Socket.IO server: ${socket.id}");
    });

    // Subscribe to channel (Echo uses naming: `channel:event`)
    socket.on("rexmfb-channel:.inward-notification", (data) {
      debugPrint("📩 Event received: $data");
    });

    // Handle disconnect
    socket.onDisconnect((_) {
      debugPrint("❌ Disconnected from Socket.IO server");
    });

    // Finally connect
    socket.connect();
  }

  void dispose() {
    socket.dispose();
  }
}*/
