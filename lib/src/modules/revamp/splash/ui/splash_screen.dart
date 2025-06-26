import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/splash/provider/setup_notifier.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //ref.refresh(setupProvider.notifier).checkForceUpdate(context);
      //ref.read(setupProvider.notifier).goToNextPage(context);
      ref.read(setupProvider.notifier).setUpAppVersion(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexPurpleLight,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AssetPath.rexLogoPath),
          ),
        ],
      ),
    );
  }
}
