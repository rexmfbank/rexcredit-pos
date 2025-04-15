// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final PusherChannelsFlutter pusher =
      PusherChannelsFlutter.getInstance();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Initialize Pusher
    await pusher.init(
      apiKey: "f3c0069a2d675f6e82bd",
      cluster: "eu",
      onEvent: (event) {
        _showNotification(event.eventName, event.data);
      },
    );

    await pusher.subscribe(
      channelName: "rexmfb-channel",
      onEvent: (event) {
        _showNotification("New Message", event.data);
      },
    );

    // await pusher.bind(
    //   channelName: "rexmfb-channel",
    //   eventName: "inward-notification",
    //   onEvent: (event) {
    //     _showNotification("New Message", event.data);
    //   },
    // );

    await pusher.connect();
  }

  static Future<void> _showNotification(
    String title,
    String body,
  ) async {
    print("EVENT NAME: $title");
    print("EVENT DATA: $body");
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, details);

    final context = rootNavKey.currentState?.overlay?.context;
    if (context != null) {
      showModalForInwardNotification(
        context,
        jsonDecode(body)['message'],
      );
    }
  }
}

void showInAppNotification({
  required String title,
  required String message,
  String? imageUrl,
}) {
  showOverlayNotification(
    (context) {
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
    },
    duration: const Duration(
      seconds: 5,
    ),
  );
}
