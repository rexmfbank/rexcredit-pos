import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class PersonalInfoDisplayPicture extends ConsumerWidget {
  const PersonalInfoDisplayPicture(
      {super.key, this.title = StringAssets.profilePicText, this.imageUrl});

  final String? title;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                image: imageUrl != null
                    ? NetworkImage(imageUrl!)
                    : const AssetImage(AssetPath.takePicture) as ImageProvider,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
