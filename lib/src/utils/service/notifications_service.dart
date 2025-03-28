import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class NotificationService {
  static Future<void> init() async {}
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
