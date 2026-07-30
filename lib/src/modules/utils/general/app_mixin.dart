import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/utils/general/app_config.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';

mixin RexAppMixin {
  Future<void> setUpAppVersion() async {
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
}