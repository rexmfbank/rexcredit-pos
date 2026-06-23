// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/splash/setup_model.dart';
import 'package:rex_app/src/modules/utils/general/app_config.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/utils/app_keys.dart';


final setupProvider = NotifierProvider<SetupNotifier, SetupModel>(
  () => SetupNotifier(),
);

class SetupNotifier extends Notifier<SetupModel> {
  @override
  SetupModel build() => const SetupModel();

  Future<void> setUpAppVersion(BuildContext context) async {
    final PackageInfo appVersion = await PackageInfo.fromPlatform();
    final version =
        AppConfig.shared.flavor == Flavor.dev
            ? appVersion.version.substring(0, 5)
            : appVersion.version;
    final config = AppKeysStorage.getConfig();
    final updateConfig = config.copyWith(appVersionLocal: version);
    await AppKeysStorage.saveConfig(updateConfig);
    goToNextPage(context);
  }

  void goToNextPage(BuildContext context) async {
    await wait(2000);
    context.go(Routes.homeScreen);
  }

  Future<void> wait(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  }
}
