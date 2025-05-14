import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/routes/routes_top.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/config/theme/global_app_bar_theme.dart';
import 'package:rex_app/src/modules/shared/pos_device/pos_card_method_channel.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/service/secure_storage.dart';

class RexApp extends ConsumerStatefulWidget {
  final Duration inactivityDuration;
  final VoidCallback? onNoActiveInteraction;

  const RexApp({
    super.key,
    this.inactivityDuration = const Duration(minutes: 2),
    this.onNoActiveInteraction,
  });

  @override
  ConsumerState<RexApp> createState() => _RexAppState();
}

class _RexAppState extends ConsumerState<RexApp> {
  late Timer logoutTimer;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      _initialiseTimer();
    });
    saveImageOnStartup();
  }

  void saveImageOnStartup() async {
    final path = await saveAssetImageToGallery(
      assetPath: 'assets/png/rex_logo_2.png',
      imageName: 'rex_logo_2.png',
    );
    if (path != null) {
      debugPrint("Image saved to: $path");
      ref.read(printingImageProvider.notifier).state = path;
    }
  }

  @override
  void dispose() {
    logoutTimer.cancel();
    super.dispose();
  }

  void _initialiseTimer() async {
    bool initiateLogTimer = widget.onNoActiveInteraction != null;
    logoutTimer = Timer.periodic(
      widget.inactivityDuration,
      (_) async {
        final loggingState = await SecureStorage().getLaunchState();
        bool performFunction =
            (rexGoRouter.location == RouteName.login || loggingState == 'FL');

        if (performFunction) {
          logoutTimer.cancel();
          return;
        }

        if (initiateLogTimer) {
          widget.onNoActiveInteraction?.call();
          return;
        }

        rexGoRouter.go(RouteName.login);
        logoutTimer.cancel();
        return;
      },
    );
  }

  void _handleUserInteraction() {
    logoutTimer.cancel();
    _initialiseTimer();
  }

  void _runInteractionHandler() async {
    final loggingState = await SecureStorage().getLaunchState();
    bool performFunction =
        (rexGoRouter.location == RouteName.login || loggingState == 'FL');

    if (performFunction) {
      logoutTimer.cancel();
      return;
    }

    _handleUserInteraction();
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
        return OverlaySupport.global(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: true,
            ),
            child: Listener(
              onPointerDown: (_) => _runInteractionHandler(),
              onPointerCancel: (_) => _runInteractionHandler(),
              onPointerUp: (_) => _runInteractionHandler(),
              onPointerMove: (_) => _runInteractionHandler(),
              onPointerHover: (_) => _runInteractionHandler(),
              onPointerSignal: (_) => _runInteractionHandler(),
              behavior: HitTestBehavior.deferToChild,
              child: MaterialApp.router(
                title: StringAssets.appTitle,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  useMaterial3: false,
                  appBarTheme: globalAppBarTheme,
                  primaryColor: AppColors.rexPurpleLight,
                  scaffoldBackgroundColor: AppColors.rexBackground,
                  fontFamily: "Inter",
                ),
                routerConfig: rexGoRouter,
              ),
            ),
          ),
        );
      },
    );
  }
}
