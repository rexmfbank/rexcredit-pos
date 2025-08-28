// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:rex_app/src/modules/revamp/utils/config/secure_storage.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

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
    // Also show in-app modal sheet if we have a navigator context
    final context = rootNavKey.currentState?.overlay?.context;
    if (context != null) {
      // showModalForInwardNotification
      showNotificationModalSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
      );
    }
  }
}

showNotificationModalSheet({
  required BuildContext context,
  bool isDismissible = false,
  bool enableDrag = true,
  void Function()? onPressed,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isDismissible: isDismissible,
    isScrollControlled: true,
    enableDrag: enableDrag,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.0),
        topRight: Radius.circular(24.0),
      ),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.50,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Payment Received',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40.ah),
              Text("You have just received [00,000] from [Customer Name]"),
              SizedBox(height: 90.ah),
              Text(
                "\u20A6 00,000",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Row(
                children: [
                  Expanded(
                    child: RexElevatedButton(
                      onPressed: () => context.pop(),
                      buttonTitle: 'Ok',
                    ),
                  ),
                  SizedBox(width: 8.aw),
                  Expanded(
                    child: RexElevatedButton(
                      onPressed: () {},
                      buttonTitle: 'Print Receipt',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
