import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/update_residential_address_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ImageUploadWidget extends ConsumerWidget {
  final String? title;
  const ImageUploadWidget({super.key, this.title});

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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title != null ? title! : StringAssets.uploadImageofId,
              style: const TextStyle(
                  color: AppColors.rexPurpleDark3,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ref.watch(updateResidentialAddressProvider).fileFromDevice !=
                    null
                ? Image.file(
                    ref.watch(updateResidentialAddressProvider).fileFromDevice!,
                    fit: BoxFit.contain,
                  )
                : null,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ref
                        .read(updateResidentialAddressProvider.notifier)
                        .pickImage(context, StringAssets.camera);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: AppColors.rexWhite,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text(StringAssets.takePicture),
                ),
              ),
              // VerticalDivider(),
              Expanded(
                child: TextButton.icon(
                  onPressed: () {
                    ref
                        .read(updateResidentialAddressProvider.notifier)
                        .pickImage(context, StringAssets.gallery);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: AppColors.rexWhite,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.image),
                  label: const Text(StringAssets.uploadPhoto),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
