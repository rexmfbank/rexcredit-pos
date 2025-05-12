// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/app_route.dart';
import 'package:rex_app/src/config/app_config.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/splash/provider/setup_model.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:url_launcher/url_launcher.dart';

final setupProvider = NotifierProvider<SetupNotifier, SetupModel>(
  () => SetupNotifier(),
);

class SetupNotifier extends Notifier<SetupModel> {
  @override
  SetupModel build() => const SetupModel();

  void navigateToStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.rexmfb.mobile' : 'id6472193945';
      final url = Uri.parse(
        Platform.isAndroid
            ? "market://details?id=$appId"
            : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> setUpAppVersion(BuildContext context) async {
    final PackageInfo appVersion = await PackageInfo.fromPlatform();
    ref.read(appVersionProvider.notifier).state =
        AppConfig.shared.flavor == Flavor.dev
            ? appVersion.version.substring(0, 5)
            : appVersion.version;
    goToNextPage(context);
  }

  Future<void> checkForceUpdate(BuildContext context) async {
    final PackageInfo appVersion = await PackageInfo.fromPlatform();
    try {
      final apiResponse = await RexApi.instance.checkForceUpdate(
        appVersion: AppConfig.shared.flavor == Flavor.dev
            ? appVersion.version.substring(0, 5)
            : appVersion.version,
      );
      state = state.copyWith(updateInfo: apiResponse.data);
      if (apiResponse.data != null && apiResponse.data!.forceUpdate == true) {
        if (context.mounted) {
          context.go(RouteName.updateAvailable);
        }
        return;
      }
      if (context.mounted) {
        goToNextPage(context);
      }
    } catch (error) {
      if (context.mounted) {
        context.showToast(message: StringAssets.updateCheckFailed);
        goToNextPage(context);
      }
    }
  }

  void goToNextPage(BuildContext context) async {
    await wait(2000);
    context.go(RouteName.login);
    // if (context.mounted) {
    //   AppRoute().routeNavigation(context);
    // }
  }

  // void checkPOSInfo() async {
  //   try {
  //     var posInformationString = "";
  //     if (posInformationString.isNotBlank) {
  //       var posInformation =
  //           PosInformation.posInformationFromMap(posInformationString);
  //       ref.read(posInfoProvider.notifier).state = posInformation;
  //       ref.read(mobileTypeProvider.notifier).state = DeviceType.pos.jsonString;
  //     }
  //   } catch (e) {
  //     ref.read(mobileTypeProvider.notifier).state =
  //         DeviceType.mobile.jsonString;
  //     debugPrint(e.toString());
  //   }
  // }

  Future<void> wait(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }
}
