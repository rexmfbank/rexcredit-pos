import 'dart:io';

import 'package:appcheck/appcheck.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

Future<void> launchRexAppStore() async {
  const packageNames = [
    'com.globalaccelerex.appstore.mock',
    'com.globalaccelerex.appstore',
  ];

  for (final packageName in packageNames) {
    final config = AppKeysStorage.getConfig();
    final isInstalled = await AppCheck().isAppInstalled(packageName);
    if (isInstalled) {
      debugPrintDev('App Store is installed: $packageName');
      final updateConfig = config.copyWith(isAppUpdated: 'true');
      await AppKeysStorage.saveConfig(updateConfig);
      await LaunchApp.openApp(
        androidPackageName: packageName,
        openStore: false,
      );
      exit(0);
    }
  }
  debugPrintDev('No App Store package is installed');
}

class UpdateButton extends StatelessWidget {
  const UpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: ElevatedButton.icon(
        onPressed: () {
          launchRexAppStore();
        },
        icon: const Icon(Icons.file_download_outlined, color: Colors.white),
        label: const Text(
          'Update App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryGreen,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
      ),
    );
  }
}

class VersionInfoCard extends StatelessWidget {
  const VersionInfoCard({
    super.key,
    required this.current,
    required this.latest,
  });

  final String current;
  final String latest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.versionBg,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          VersionRow(
            label: 'Current version',
            version: current,
            versionColor: AppColors.errorRed,
          ),
          const SizedBox(height: 12.0),
          VersionRow(
            label: 'Latest version',
            version: latest,
            versionColor: AppColors.successGreen,
          ),
        ],
      ),
    );
  }
}

class VersionRow extends StatelessWidget {
  const VersionRow({
    super.key,
    required this.label,
    required this.version,
    required this.versionColor,
  });

  final String label;
  final String version;
  final Color versionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textGrey2,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          version,
          style: TextStyle(
            color: versionColor,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WarningIcon extends StatelessWidget {
  const WarningIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF7ED),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.warning_amber_rounded,
          color: AppColors.warningOrange,
          size: 40,
        ),
      ),
    );
  }
}
