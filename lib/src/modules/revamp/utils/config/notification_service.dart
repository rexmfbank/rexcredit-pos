// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
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

    await flutterLocalNotificationsPlugin.initialize(initSettings);
    await _ensureInwardChannel();

    await pusher.init(apiKey: _apiKey, cluster: "eu");

    await pusher.subscribe(
      channelName: "rexmfb-channel",
      onSubscriptionError: (v1, v2) {},
      onEvent: (event) async {
        final acctNumber = await SecureStorage().getPosNuban();
        debugPrint("EVENT: $event");
        debugPrint("ACCOUNT NUMBER: $acctNumber");
        if (event.eventName == "inward-notification") {
          final eventData = jsonDecode(event.data);
          final num = eventData['transaction']['accountNo'];
          if (num == acctNumber) {
            _showNotification(
              "Inward Transfer",
              eventData['transaction']['message'],
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

  static Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'rexmfb_inward',
          'Inward Transfers',
          importance: Importance.high,
          priority: Priority.high,
          groupKey: 'rexmfb',
          playSound: true,
          sound: RawResourceAndroidNotificationSound('posbeep'),
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    final id = DateTime.now().millisecondsSinceEpoch.remainder(1 << 31);
    await flutterLocalNotificationsPlugin.show(id, title, body, details);
  }
}

/*
final context = rootNavKey.currentState?.overlay?.context;
    if (context != null) {
      showModalForInwardNotification(
        context,
        jsonDecode(body)['message'],
      );
    }
*/

void showInAppNotification({
  required String title,
  required String message,
  String? imageUrl,
}) {
  showOverlayNotification((context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 10.ah),
          GestureDetector(
            onTap: () {
              OverlaySupportEntry.of(context)?.dismiss();
            },
            child: Card(
              elevation: 0.8,
              margin: EdgeInsets.symmetric(horizontal: 20.aw),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.aw,
                  vertical: 20.ah,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/png/rex_logo_2.png",
                      height: 30.ah,
                      width: 30.aw,
                    ),
                    SizedBox(width: 10.aw),
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.asp,
                                ),
                              ),
                              SizedBox(height: 5.ah),
                              SizedBox(
                                width: 270.aw,
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.asp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (imageUrl.isNotBlank) ...[
                            RexNetworkImage(image: imageUrl),
                            SizedBox(width: 8.aw),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }, duration: const Duration(seconds: 5));
}
