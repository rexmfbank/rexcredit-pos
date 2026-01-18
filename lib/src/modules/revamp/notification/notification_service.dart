// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_helper.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/routes_top.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String audioFilename = 'posbeep';

  // static final _socketUrl =
  //     ApiConfig.shared.flavor == ApiFlavor.dev
  //         ? 'https://rex-socket.onrender.com'
  //         : 'wss://rex-socket.onrender.com';

  static final _socketUrl = 'https://rex-socket.onrender.com';

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
      debugPrintDev('Connected to Socket.IO server');
      socket.emit('subscribe', {'channel': 'rexmfb-channel'});
    });

    socket.on('inward-notification', (data) async {
      final acctNumber = await AppSecureStorage().getPosNuban();

      debugPrintDev('Inward Notification Data: $data');

      final payload = PosNotification.fromJson(data);
      if (payload.terminalSerialNo == "P332600087595") {
        _showNotificationV2(
          title: "Payment Info",
          body: bodyOfPushNotifV2(payload),
          data: payload,
        );
      }
    });

    socket.onDisconnect((_) {});
    socket.onConnectError((data) {
      debugPrintDev('Socket.IO connection error: $data');
    });
    socket.onError((data) {
      debugPrintDev('Socket.IO error: $data');
    });
    socket.onError((data) {
      debugPrintDev('Socket.IO general error: $data');
    });
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

  static Future<void> _showNotificationV2({
    required String title,
    required String body,
    required PosNotification data,
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
      showNotificationModalSheetV2(context: context, data: data);
    }
  }
}
