import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/form_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class CardReplacementPage extends ConsumerStatefulWidget {
  const CardReplacementPage({super.key});

  @override
  ConsumerState<CardReplacementPage> createState() =>
      _CardReplacementPageState();
}

class _CardReplacementPageState extends ConsumerState<CardReplacementPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cardNotifier.notifier).getReplacementReasons(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        title: StringAssets.cardReplacement,
        subtitle: StringAssets.createAndDeliverCardPrompt,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(height: 10.ah),
          const RexTextFieldRichText(
            title1: StringAssets.selectReason,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          CustomDropDownButton(
            height: 56.ah,
            items: ref
                .watch(cardNotifier)
                .cardReplacementReasons
                .map((e) => e.description ?? '')
                .toList(),
            backGroundColor: AppColors.rexWhite,
            dropdownValue: ValueNotifier(
                ref.watch(cardNotifier).selectedReplacementReason),
            withHint: false,
            onChanged: (String? value) =>
                ref.watch(cardNotifier.notifier).updateReplacementReason(value),
          ),
          SizedBox(height: 20.ah),
          const RexTextFieldRichText(
            title1: StringAssets.enterCurrentPin,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 5.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.enterCurrentPin,
            controller: ref.watch(cardNotifier).replacementCardPinController,
            backgroundColor: AppColors.rexWhite,
            obscureText: ref.watch(cardNotifier).obscureCurrentPassword,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.pin(value),
            suffixIcon: InkWell(
              onTap: () => ref
                  .watch(cardNotifier.notifier)
                  .toggleReplacementCurrentPin(),
              child: Icon(
                ref.watch(cardNotifier).obscureReplacePin
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18.ar,
                color: ref.watch(cardNotifier).obscureReplacePin
                    ? AppColors.rexPurpleLight
                    : AppColors.rexTint500,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () =>
                ref.watch(cardNotifier.notifier).validateReplaceCard(context),
            buttonTitle: StringAssets.continueTextOnButton,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
