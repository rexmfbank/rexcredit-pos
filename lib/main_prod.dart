import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/firebase_options.dart';
import 'package:rex_app/src/app.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_service2.dart';
import 'package:rex_app/src/modules/revamp/utils/app_config.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/revamp/notification/notification_service.dart';
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
  runZonedGuarded<Future<void>>(() async {
    setUpAppConfig();
    setUpApiConfig();

    WidgetsFlutterBinding.ensureInitialized();
    await NotificationService2.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // Pass all uncaught asynchronous errors that aren't handled
    // by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

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
