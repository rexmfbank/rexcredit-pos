import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_picture_provider.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PersonalInfoPicture extends ConsumerWidget {
  const PersonalInfoPicture(
      {super.key, this.title = StringAssets.profilePicText});

  final String? title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picture = ref.watch(registerPictureProvider);
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringAssets.profilePicText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: picture.imageFromDevice != null
                    ? FileImage(picture.imageFromDevice!)
                    : const AssetImage(AssetPath.takePicture) as ImageProvider,
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
            label: const Text(StringAssets.takePicText),
          )
        ],
      ),
    );
  }
}
