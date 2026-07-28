import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/notification/notification_service.dart';
import 'package:rex_app/src/modules/utils/general/app_config.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class RexApp extends ConsumerStatefulWidget {
  const RexApp({super.key});

  @override
  ConsumerState<RexApp> createState() => _RexAppState();
}

class _RexAppState extends ConsumerState<RexApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _setUpAppVersion();
      await NotificationService.init();
    });
  }

  Future<void> _setUpAppVersion() async {
    // 1. Check encryption status first — must be resolved before any API call
    bool encryptionOn = false;
    try {
      final res = await RexApi.instance.checkEncryption();
      encryptionOn = res.payloadEncryption ?? false;
      debugPrintDev("Encryption status: ${res.payloadEncryption}");
    } catch (err, _) {
      debugPrintDev("error on checking encryption: $err");
    }

    // 2. Get app version
    final PackageInfo appVersion = await PackageInfo.fromPlatform();
    final version =
        AppConfig.shared.flavor == Flavor.dev
            ? appVersion.version.substring(0, 5)
            : appVersion.version;

    // 3. Save both encryption flag and app version in a single config update
    final config = AppKeysStorage.getConfig();
    final updateConfig = config.copyWith(
      onEncryption: encryptionOn,
      appVersionLocal: version,
    );
    await AppKeysStorage.saveConfig(updateConfig);
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
            ),
          ),
        );
      },
    );
  }
}
