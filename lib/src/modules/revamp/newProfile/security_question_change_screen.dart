import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/newProfile/security_question_screen_notifier.dart';
import 'package:rex_app/src/modules/revamp/newProfile/security_question_providers.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SecurityQuestionChangeScreen extends ConsumerStatefulWidget {
  const SecurityQuestionChangeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecurityQuestionChangeScreenState();
}

class _SecurityQuestionChangeScreenState
    extends ConsumerState<SecurityQuestionChangeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(securityQuestionScreenProvider);
    return AppScaffold(
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: 'Change Security Question',
      ),
      body: ListView(
        children: [
          const SecurityQuestionDropdown(),
          RexTextField(
            outerTitle: StringAssets.securityAnswer,
            showOuterTile: true,
            hintText: StringAssets.securityAnswer,
            controller: provider.answerController,
            obscureText: false,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RexElevatedButton(
              onPressed: () {
                ref
                    .read(securityQuestionScreenProvider.notifier)
                    .submitQuestion(context: context);
              },
              buttonTitle: 'Confirm',
            ),
          ),
        ],
      ),
    );
  }
}

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
          const SizedBox(height: 16),
          Text(
            StringAssets.selectSecurityQuestion,
            style: AppTextStyles.h2.copyWith(color: AppColors.rexPurpleDark),
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
                  items:
                      data.map<
                        DropdownMenuItem<FetchLookupDataByCodeResponseData>
                      >((question) {
                        return DropdownMenuItem(
                          value: question,
                          child: Text(question.name),
                        );
                      }).toList(),
                  onChanged: (FetchLookupDataByCodeResponseData? value) {
                    ref
                        .read(securityQuestionScreenProvider.notifier)
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
          ),
        ],
      ),
    );
  }
}
