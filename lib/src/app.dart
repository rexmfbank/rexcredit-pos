import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rex_app/src/modules/notification/notification_service.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

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
      await NotificationService.init();
      // saveImageOnStartup();
    });
  }

  // void saveImageOnStartup() async {
  //   final path = await saveImageToPublicStorage();
  //   if (path == null) {
  //     ref.read(printingImageProvider.notifier).state = '';
  //   } else {
  //     ref.read(printingImageProvider.notifier).state = path;
  //   }
  // }

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
