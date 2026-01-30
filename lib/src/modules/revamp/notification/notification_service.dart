// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_helper.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_model.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_widget.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/routes_top.dart';
import 'package:socket_io_client/socket_io_client.dart' as socketio;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String audioFilename = 'beeptwo';
  static const String audioSource = 'audio/beeptwo.wav';

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
      onDidReceiveNotificationResponse: (response) {},
    );
    await _ensureInwardChannel();

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
      final serialNo = await AppSecureStorage().getPosSerialNo() ?? '';
      debugPrintDev("Data from socket: $data");

      if (data is! Map<String, dynamic>) {
        debugPrintDev('Invalid notification data format: $data');
        return;
      }

      if (_isPosNotification(data)) {
        debugPrintDev('PosNotification Data: $data');
        final payload = PosNotification.fromJson(data);
        if (payload.terminalSerialNo == serialNo) {
          _showDataPosNotification(
            title: "Payment Info",
            body: bodyOfPushNotifV2(payload),
            data: payload,
          );
        }
      } else if (_isInTransferNotification(data)) {
        debugPrintDev('InTransferNotification Data: $data');
        try {
          final transferData = data['transferData'];
          final Map<String, dynamic> transferDataMap =
              Map<String, dynamic>.from(transferData as Map);
          final tData = InTransferData.fromJson(transferDataMap);
          if (tData.serialNo == serialNo) {
            _showDataInTransfer(
              title: "Payment Received",
              body: bodyOfPushNotif(tData),
              data: tData,
            );
          } else {
            debugPrintDev('SerialNo mismatch - notif not for this device');
          }
        } catch (e, stackTrace) {
          debugPrintDev('Error parsing InTransferNotification: $e');
          debugPrintDev('StackTrace: $stackTrace');
        }
      } else {
        debugPrintDev('Unknown notification type: $data');
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

  static Future<void> _showDataPosNotification({
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

    final player = AudioPlayer();
    await player.play(AssetSource(audioSource));

    final context = rootNavKey.currentState?.overlay?.context;
    if (context != null) {
      showModalPosNotification(context: context, data: data);
    }
  }

  static Future<void> _showDataInTransfer({
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
      showModalInTransfer(context: context, data: data);
    }
  }

  static bool _isPosNotification(Map<String, dynamic> data) {
    return data.containsKey('terminalSerialNo') &&
        data.containsKey('rrn') &&
        data.containsKey('stan');
  }

  static bool _isInTransferNotification(Map<String, dynamic> data) {
    return data.containsKey('transaction') && data.containsKey('transferData');
  }
}
