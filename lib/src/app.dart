import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/routes_top.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/global_app_bar_theme.dart';
import 'package:rex_app/src/modules/revamp/pos_device/notifier/pos_method_channel.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

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
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) {
      saveImageOnStartup();
    });
  }

  void saveImageOnStartup() async {
    final path = await saveImageToPublicStorage();
    if (path == null) {
      ref.read(printingImageProvider.notifier).state = '';
    } else {
      ref.read(printingImageProvider.notifier).state = path;
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
        return OverlaySupport.global(
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              systemStatusBarContrastEnforced: true,
            ),
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
        );
      },
    );
  }
}
