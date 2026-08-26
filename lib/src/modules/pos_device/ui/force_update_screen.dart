// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/ui/force_update_widgets.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class ForceUpdateScreen extends ConsumerStatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends ConsumerState<ForceUpdateScreen> {
  String _versionLocal = '';
  String _versionServer = '';

  @override
  void initState() {
    super.initState();
    _loadVersions();
  }

  Future<void> _loadVersions() async {
    final config = AppKeysStorage.getConfig();
    final local = config.appVersionLocal;
    final server = config.appVersionServer;
    setState(() {
      _versionLocal = local;
      _versionServer = server;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarSubScreen(
        title: 'Update',
        centerTitle: true,
        onBackBtnPress: () async {
          final config = AppKeysStorage.getConfig();
          final updateConfig = config.copyWith(isAppUpdated: "false");
          await AppKeysStorage.saveConfig(updateConfig);
          context.pop();
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(28.0),
                ),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const WarningIcon(),
                    const SizedBox(height: 24.0),
                    const Text(
                      Strings.update1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      Strings.update2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: AppColors.textGrey2,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    VersionInfoCard(
                      current: _versionLocal,
                      latest: _versionServer,
                    ),
                    const SizedBox(height: 32.0),
                    const UpdateButton(),
                    const SizedBox(height: 20.0),
                    const Text(
                      Strings.update3,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AppColors.textGrey2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
