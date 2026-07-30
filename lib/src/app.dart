import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/modules/notification/notification_service.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_mixin.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class RexApp extends ConsumerStatefulWidget {
  const RexApp({super.key});

  @override
  ConsumerState<RexApp> createState() => _RexAppState();
}

class _RexAppState extends ConsumerState<RexApp>
    with WidgetsBindingObserver, RexAppMixin {
  Timer? _inactivityTimer;
  DateTime _lastInteractionTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await setUpAppVersion();
      await NotificationService.init();
    });
    rexGoRouter.routerDelegate.addListener(_onRouteChange);
  }

  void _onRouteChange() {
    final currentLocation =
        rexGoRouter.routerDelegate.currentConfiguration.uri.toString();
    final isExcluded = Routes.excludedRoutes.contains(currentLocation);
    if (!isExcluded) {
      _startInactivityTimer();
    } else {
      _inactivityTimer?.cancel();
    }
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    _lastInteractionTime = DateTime.now();
    _inactivityTimer = Timer(const Duration(minutes: 2), _handleLogoutRedirect);
  }

  void _handleLogoutRedirect() {
    final routerDelegate = rexGoRouter.routerDelegate;
    final currentLocation = routerDelegate.currentConfiguration.uri.toString();

    final isExcluded = Routes.excludedRoutes.contains(currentLocation);
    if (!isExcluded) {
      rexGoRouter.go(Routes.login);
    }
  }

  void _handleUserInteraction([_]) {
    final currentLocation =
        rexGoRouter.routerDelegate.currentConfiguration.uri.toString();
    final isExcluded = Routes.excludedRoutes.contains(currentLocation);
    if (!isExcluded) {
      _startInactivityTimer();
    }
  }

  @override
  void dispose() {
    rexGoRouter.routerDelegate.removeListener(_onRouteChange);
    _inactivityTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        debugPrintDev("AppLifecycleState:detached|inactive");
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        _inactivityTimer?.cancel();
        break;
      case AppLifecycleState.resumed:
        final currentLocation =
            rexGoRouter.routerDelegate.currentConfiguration.uri.toString();
        final isExcluded = Routes.excludedRoutes.contains(currentLocation);
        if (!isExcluded) {
          final timeSinceLastInteraction = DateTime.now().difference(
            _lastInteractionTime,
          );
          if (timeSinceLastInteraction.inSeconds >= 120) {
            _handleLogoutRedirect();
          } else {
            final remaining =
                const Duration(minutes: 2) - timeSinceLastInteraction;
            _inactivityTimer?.cancel();
            _inactivityTimer = Timer(remaining, _handleLogoutRedirect);
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      splitScreenMode: false,
      builder: (context, child) {
        return Listener(
          onPointerDown: _handleUserInteraction,
          child: Focus(
            onKeyEvent: (node, event) {
              _handleUserInteraction();
              return KeyEventResult.ignored;
            },
            child: OverlaySupport.global(
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                  systemStatusBarContrastEnforced: false,
                ),
                child: MaterialApp.router(
                  title: Strings.appTitle,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: false,
                    primaryColor: AppColors.rexPurpleLight,
                    scaffoldBackgroundColor: AppColors.rexBackground,
                    fontFamily: "Inter",
                  ),
                  routerConfig: rexGoRouter,
                  scaffoldMessengerKey: scaffoldMessengerKey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
