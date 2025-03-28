import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/zoho_config.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/analytics/analytics_event.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'dart:io' as io;

class ChatScreenWidget extends ConsumerStatefulWidget {
  const ChatScreenWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends ConsumerState<ChatScreenWidget> {
  bool hasBeenInitialized = false;

  @override
  void initState() {
    super.initState();
    initZohoChat();
  }

  Future<void> initZohoChat() async {
    if (io.Platform.isIOS || io.Platform.isAndroid) {
      String appKey = '';
      String accessKey = '';
      if (ApiConfig.shared.flavor == ApiFlavor.dev) {
        // initializing keys in debug mode
        if (io.Platform.isIOS) {
          appKey = ZohoConfig.devAppKeyIOS;
          accessKey = ZohoConfig.devAccessKeyIOS;
        } else {
          appKey = ZohoConfig.devAppKeyAndroid;
          accessKey = ZohoConfig.devAccessKeyAndroid;
        }
      } else {
        // initializing keys in production mode
        if (io.Platform.isIOS) {
          appKey = ZohoConfig.prodAppKeyIOS;
          accessKey = ZohoConfig.prodAccessKeyIOS;
        } else {
          appKey = ZohoConfig.prodAppKeyAndroid;
          accessKey = ZohoConfig.prodAccessKeyAndroid;
        }
      }

      // initialize Zoho chat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.ah),
        SizedBox(
          width: 350.aw,
          height: 350.ah,
          child: Lottie.asset(LottieAsset.chatAnimation),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              StringAssets.chatScreenT3,
              style: AppTextStyles.h3b,
            ),
          ),
        ),
        RexElevatedButton(
          onPressed: () async {
            if (hasBeenInitialized) {
              // analaytics service
            } else {
              context.showToast(message: StringAssets.chatScreenT5);
            }
          },
          buttonTitle: StringAssets.chatScreenT4,
        ),
      ],
    );
  }
}
