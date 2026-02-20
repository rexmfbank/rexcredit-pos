import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/app.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_service.dart';
import 'package:rex_app/src/modules/revamp/utils/app_config.dart';
import 'package:rex_app/src/modules/revamp/api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/app_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setUpAppConfig() {
  AppConfig.create(flavor: Flavor.prod);
}

void setUpApiConfig() {
  ApiConfig.create(
    baseUrl: "https://web.rexmfbank.com/api",
    imageBaseUrl: 'https://productlogos.s3.us-west-2.amazonaws.com/',
    flavor: ApiFlavor.prod,
  );
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    setUpAppConfig();
    setUpApiConfig();

    WidgetsFlutterBinding.ensureInitialized();
    await NotificationService.init();

    if (defaultTargetPlatform == TargetPlatform.android) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
    final prefs = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const RexApp(),
      ),
    );
  }, (error, stack) {});
}
