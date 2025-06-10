import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rex_app/firebase_options.dart';
import 'package:rex_app/src/app.dart';
import 'package:rex_app/src/config/app_config.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
import 'package:rex_app/src/utils/service/notifications_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setUpAppConfig() {
  AppConfig.create(flavor: Flavor.prod);
}

void setUpApiConfig() {
  ApiConfig.create(
    baseUrl: "https://rexbank.globalaccelerex.com/baas/api/v1",
    imageBaseUrl: 'https://productlogos.s3.us-west-2.amazonaws.com/',
    flavor: ApiFlavor.prod,
  );
}

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      setUpAppConfig();
      setUpApiConfig();

      WidgetsFlutterBinding.ensureInitialized();
      await NotificationService.init();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Pass all uncaught "fatal" errors from the framework to Crashlytics
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      // Pass all uncaught asynchronous errors that aren't handled
      // by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

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
    },
    (error, stack) {},
  );
}
