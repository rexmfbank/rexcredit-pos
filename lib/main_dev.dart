import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/app.dart';
import 'package:rex_app/src/config/app_config.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/utils/service/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void initNotificationOnMobile() async {
  ///Firebase Initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationService.init();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
}

void setUpAppConfig() {
  AppConfig.create(
    flavor: Flavor.dev,
  );
}

void setUpApiConfig() {
  ApiConfig.create(
    baseUrl: "https://baascore-dev.globalaccelerex.com/baas/api/v1",
    imageBaseUrl: 'https://productlogos.s3.us-west-2.amazonaws.com/',
    flavor: ApiFlavor.dev,
  );
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    setUpAppConfig();
    setUpApiConfig();
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) {
      try {
        initNotificationOnMobile();
      } catch (e) {
        initNotificationOnMobile();
      }
    } else {
      initNotificationOnMobile();
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
      ),
    );

    final prefs = await SharedPreferences.getInstance();

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          loggerProvider.overrideWithValue(Logger()),
        ],
        child: const RexApp(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
