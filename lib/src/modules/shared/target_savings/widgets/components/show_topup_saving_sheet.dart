import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/show_fund_saving_topup.dart';
import 'package:rex_app/src/modules/shared/widgets/filter_modal_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showTopupSavingSheet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        final saveProvider = ref.watch(targetSavingProvider);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: FilterModalHeader(
                    title: StringAssets.topupSaveTitle,
                    subtitle: StringAssets.topupSaveSubtitle,
                  ),
                ),
                const SizedBox(height: 8.0),
                RexTextField(
                  controller: saveProvider.topupController,
                  outerTitle: 'Top up amount',
                  hintText: 'Enter amount',
                  inputType: TextInputType.number,
                  showOuterTile: true,
                  textFieldIsRequired: true,
                  obscureText: false,
                ),
                RexElevatedButton(
                  onPressed: () {
                    context.pop();
                    showFundSavingTopup(context: context);
                  },
                  buttonTitle: StringAssets.saveTextOnButton,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
