import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/models/file_upload/file_upload_notifier.dart';
import 'package:rex_app/src/modules/shared/models/kyc/upload_model.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class UploadDocumentWidget extends ConsumerWidget {
  final String title;
  final String? uploadInstructions;
  final List<String>? allowedExtensions;
  final ValueChanged<UploadModel> onUpload;
  const UploadDocumentWidget({
    super.key,
    required this.title,
    required this.onUpload,
    this.uploadInstructions,
    this.allowedExtensions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleDark,
            ),
          ),
        ),
        SizedBox(height: 8.ah),
        Container(
          height: 50.ah,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.rexWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.ar),
              topRight: Radius.circular(16.ar),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 14.0),
            child: Text(
              ref.watch(fileUploadNotifier).fileName == null
                  ? (uploadInstructions ?? StringAssets.uploadDocInstructions)
                  : ref.watch(fileUploadNotifier).fileName!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            ref.watch(fileUploadNotifier.notifier).showOptionModal(
                  context: context,
                  allowedExtensions: allowedExtensions,
                  onSuccess: () => onUpload.call(ref
                      .watch(fileUploadNotifier.notifier)
                      .returnFileDetails()),
                );
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.rexBrown2,
            backgroundColor: AppColors.cardBrown,
            minimumSize: Size.fromHeight(50.ah),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.ar),
              ),
            ),
          ),
          icon: ref.watch(fileUploadNotifier).isLoading
              ? const SizedBox.shrink()
              : const Icon(
                  Icons.description,
                  color: AppColors.rexBrown2,
                ),
          label:  ref.watch(fileUploadNotifier).isLoading
              ? const CupertinoActivityIndicator()
              : Text(
            StringAssets.uploadDocument,
            style: AppTextStyles.body1Regular,
          ),
        ),
      ],
    );
  }
}
