import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessFileStatusWidget extends ConsumerWidget {
  const BusinessFileStatusWidget({
    super.key,
    required this.docStatus,
  });

  final BusinessFileStatus docStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (docStatus) {
      case BusinessFileStatus.fileIsNull:
        return const _CapturedFile(
          text: StringAssets.captureFile1,
          icon: Icon(Icons.cancel, color: AppColors.red2),
        );
      case BusinessFileStatus.fileIsNotNull:
        return const _CapturedFile(
          text: StringAssets.captureFile2,
          icon: Icon(Icons.check, color: AppColors.rexGreen),
        );
      case BusinessFileStatus.fileIsUploading:
        return const _CapturedFile(
          text: StringAssets.captureFile3,
          icon: CircularProgressIndicator(
            color: AppColors.rexPurpleLight,
            strokeWidth: 2.0,
          ),
        );
      case BusinessFileStatus.fileIsUploaded:
        return const _CapturedFile(
          text: StringAssets.captureFile4,
          icon: Icon(Icons.check, color: AppColors.rexGreen),
        );
      case BusinessFileStatus.fileUploadError:
        return const _CapturedFile(
          text: StringAssets.captureFile5,
          icon: Icon(Icons.cancel_rounded, color: AppColors.red2),
        );
    }
  }
}

class _CapturedFile extends StatelessWidget {
  const _CapturedFile({
    required this.text,
    required this.icon,
  });

  final String text;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: Text(
            "[$text]",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Flexible(child: icon),
      ],
    );
  }
}
