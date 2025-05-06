import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/shared/providers/get_security_question_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SecurityQuestionDropdown extends ConsumerWidget {
  final EdgeInsets? padding;
  const SecurityQuestionDropdown({super.key, this.padding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionList = ref.watch(securityQuestionListProvider);
    //
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.aw),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            StringAssets.selectSecurityQuestion,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.rexPurpleDark,
            ),
          ),
          SizedBox(height: 10.ah),
          Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: questionList.when(
              data: (data) {
                return DropdownButtonFormField(
                  items: data
                      .map<DropdownMenuItem<FetchLookupDataByCodeResponseData>>(
                          (question) {
                    return DropdownMenuItem(
                      value: question,
                      child: Text(
                        question.name,
                      ),
                    );
                  }).toList(),
                  onChanged: (FetchLookupDataByCodeResponseData? value) {
                    ref
                        .read(securityQuestionProvider.notifier)
                        .onDropdownChange(value);
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: rexInputBorder,
                    enabledBorder: rexInputBorder,
                    focusedBorder: rexInputBorder,
                  ),
                  isExpanded: true,
                );
              },
              error: (obj, stack) => const RexDisabledDropdown(),
              loading: () => const RexDisabledDropdown(),
            ),
          )
        ],
      ),
    );
  }
}
