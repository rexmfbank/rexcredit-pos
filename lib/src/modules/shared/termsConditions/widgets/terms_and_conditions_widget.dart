import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/termsConditions/provider/terms_and_privacy_policy_provider.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TermsAndConditionsWidget extends ConsumerWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsPrivacyData = ref.watch(termsAndPrivacyPolicyProvider);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: termsPrivacyData.when(
            loading:
                () => Center(
                  child: SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(),
                  ),
                ),
            error:
                (error, stackTrace) => const Text(
                  StringAssets.termsConditionError,
                  style: TextStyle(color: AppColors.grey3),
                ),
            data: (data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Html(data: data.termsAndConditions),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
