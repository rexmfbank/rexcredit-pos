import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_logo_provider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class BusinessLogoUpload extends ConsumerWidget {
  const BusinessLogoUpload({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doc = ref.watch(businessLogoProvider);
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
              'Business Logo',
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                doc.fileName == null
                    ? 'Only jpg, and png files accepted'
                    : doc.fileName!,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              ref.read(businessLogoProvider.notifier).getImageFromDevice();
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
            label: const Text('Upload Logo'),
          )
        ],
      ),
    );
  }
}
