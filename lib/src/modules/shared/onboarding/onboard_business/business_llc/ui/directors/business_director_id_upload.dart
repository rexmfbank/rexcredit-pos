import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_picture_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessDirectorIdUpload extends ConsumerWidget {
  const BusinessDirectorIdUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RexTextFieldRichText(title1: StringAssets.uploadIDCard),
        SizedBox(height: 10.ah),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            ref.read(registerPictureProvider.notifier).getImageFromCamera();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
            backgroundColor: AppColors.rexWhite,
            minimumSize: const Size.fromHeight(50),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          icon: const Icon(Icons.photo_camera),
          label: const Text('Upload Photo'),
        )
      ],
    );
  }
}
