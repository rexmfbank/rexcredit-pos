import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class UploadDocumentModal extends StatelessWidget {
  final VoidCallback onCameraClicked;
  final VoidCallback onDocumentClicked;
  const UploadDocumentModal({
    super.key,
    required this.onCameraClicked,
    required this.onDocumentClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23.ah, horizontal: 16.aw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onCameraClicked,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                StringAssets.takePicture,
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.rexPurpleLight,
                ),
              ),
            ),
          ),
          SizedBox(height: 14.ah),
          Divider(
            thickness: 1.ah,
            color: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 14.ah),
          InkWell(
            onTap: onDocumentClicked,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                StringAssets.uploadDocument,
                style: AppTextStyles.body2Regular.copyWith(
                  color: AppColors.rexPurpleLight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
