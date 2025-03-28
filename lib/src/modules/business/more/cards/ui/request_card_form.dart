import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_adaptive_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RequestCardForm extends ConsumerStatefulWidget {
  const RequestCardForm({super.key});

  @override
  ConsumerState<RequestCardForm> createState() => _RequestCardFormState();
}

class _RequestCardFormState extends ConsumerState<RequestCardForm> {
  @override
  void initState() {
    super.initState();
    ref.read(cardNotifier.notifier).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        title: StringAssets.requestCard,
        //subtitle: StringAssets.createAndDeliverCardPrompt,
        showImage: false,
        showNotification: false,
      ),
      body: ListView(
        // controller: ref.watch(cardNotifier).requestController,
        // shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 10.ah),
          const RexTextFieldRichText(
            title1: StringAssets.accountNumber,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            controller: ref.watch(cardNotifier).walletNumberController,
            backgroundColor: AppColors.rexWhite,
            obscureText: false,
            readOnly: true,
          ),
          SizedBox(height: 3.ah),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              StringAssets.cardWillBeLinkedToAccount,
              style: AppTextStyles.body3Regular.copyWith(
                color: AppColors.rexBronzeTint100,
              ),
            ),
          ),
          SizedBox(height: 16.ah),
          const RexTextFieldRichText(
            title1: StringAssets.nameOnCard,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.nameOnCard,
            controller: ref.watch(cardNotifier).cardNameController,
            backgroundColor: AppColors.rexWhite,
            obscureText: false,
            inputType: TextInputType.name,
            validator: (value) => TextfieldValidator.businessName(value),
          ),
          SizedBox(height: 16.ah),
          const RexTextFieldRichText(
            title1: StringAssets.cardType,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          /*CustomDropDownButton(
            height: 56.ah,
            items: ref
                .watch(cardNotifier)
                .cardProducts
                .map((e) =>
                    '${e.productName ?? ''} - ${e.cardType?.displayString ?? ' '}')
                .toList(),
            backGroundColor: AppColors.rexWhite,
            dropdownValue: ValueNotifier(ref.watch(cardNotifier).selectedCard),
            withHint: false,
            onChanged: (String? value) =>
                ref.watch(cardNotifier.notifier).updateSelectedProduct(value),
          ),*/
          Container(
            decoration: BoxDecoration(color: AppColors.rexWhite),
            child: RexAdaptiveDropdown<String>(
              items: ref
                  .watch(cardNotifier)
                  .cardProducts
                  .map((e) =>
                      '${e.productName ?? ''} - ${e.cardType?.displayString ?? ' '}')
                  .toList(),
              value: ref.watch(cardNotifier).selectedCard,
              hint: '',
              onChanged: (value) {
                ref.watch(cardNotifier.notifier).updateSelectedProduct(value);
              },
            ),
          ),
          SizedBox(height: 16.ah),
          const RexTextFieldRichText(
            title1: StringAssets.deliveryOption,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          /*CustomDropDownButton(
            height: 56.ah,
            items: ref.watch(cardNotifier).deliveryOptions,
            backGroundColor: AppColors.rexWhite,
            dropdownValue:
                ValueNotifier(ref.watch(cardNotifier).selectedDelivery),
            withHint: false,
            onChanged: (String? value) =>
                ref.watch(cardNotifier.notifier).updateDeliveryOption(value),
          ),*/
          Container(
            decoration: BoxDecoration(color: AppColors.rexWhite),
            child: RexAdaptiveDropdown<String>(
              items: ref.watch(cardNotifier).deliveryOptions,
              value: ref.watch(cardNotifier).selectedDelivery,
              hint: '',
              onChanged: (value) {
                ref.watch(cardNotifier.notifier).updateDeliveryOption(value);
              },
            ),
          ),
          SizedBox(height: 16.ah),
          const RexTextFieldRichText(
            title1: StringAssets.address,
            color1: AppColors.rexPurpleDark2,
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.enterAddress,
            controller: ref.watch(cardNotifier).addressController,
            backgroundColor: AppColors.rexWhite,
            obscureText: false,
            inputType: TextInputType.streetAddress,
            validator: (value) => TextfieldValidator.input(value),
          ),
          SizedBox(height: 16.ah),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RexTextFieldRichText(
                      title1: StringAssets.state,
                      color1: AppColors.rexPurpleDark2,
                    ),
                    SizedBox(height: 7.ah),
                    /*CustomDropDownButton(
                      onTap: () =>
                          ref.watch(cardNotifier.notifier).scrollToBottom(),
                      height: 56.ah,
                      items: ref
                          .watch(cardNotifier)
                          .stateLgaResponse!
                          .map((e) => e.state.name)
                          .toList(),
                      backGroundColor: AppColors.rexWhite,
                      dropdownValue:
                          ValueNotifier(ref.watch(cardNotifier).selectedState),
                      withHint: false,
                      onChanged: (String? value) => ref
                          .watch(cardNotifier.notifier)
                          .updateSelectedState(value),
                    ),*/
                    Container(
                      decoration: BoxDecoration(color: AppColors.rexWhite),
                      child: RexAdaptiveDropdown<String>(
                        items: ref
                            .watch(cardNotifier)
                            .stateLgaResponse!
                            .map((e) => e.state.name)
                            .toList(),
                        value: ref.watch(cardNotifier).selectedState,
                        hint: '',
                        onChanged: (value) {
                          ref
                              .watch(cardNotifier.notifier)
                              .updateSelectedState(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 9.aw),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RexTextFieldRichText(
                      title1: StringAssets.city,
                      color1: AppColors.rexPurpleDark2,
                    ),
                    SizedBox(height: 7.ah),
                    /*CustomDropDownButton(
                      height: 56.ah,
                      items: ref.watch(cardNotifier).selectedState.isBlank
                          ? []
                          : ref
                              .watch(cardNotifier)
                              .stateLgaResponse!
                              .firstWhere((element) =>
                                  element.state.name ==
                                  ref.watch(cardNotifier).selectedState)
                              .state
                              .locals,
                      backGroundColor: AppColors.rexWhite,
                      dropdownValue:
                          ValueNotifier(ref.watch(cardNotifier).selectedCity),
                      withHint: false,
                      onChanged: (String? value) => ref
                          .watch(cardNotifier.notifier)
                          .updateSelectedCity(value),
                    ),*/
                    Container(
                      decoration: BoxDecoration(color: AppColors.rexWhite),
                      child: RexAdaptiveDropdown<String>(
                        items: ref.watch(cardNotifier).selectedState.isBlank
                            ? []
                            : ref
                                .watch(cardNotifier)
                                .stateLgaResponse!
                                .firstWhere((element) =>
                                    element.state.name ==
                                    ref.watch(cardNotifier).selectedState)
                                .state
                                .locals,
                        value: ref.watch(cardNotifier).selectedCity,
                        hint: '',
                        onChanged: (value) => ref
                            .watch(cardNotifier.notifier)
                            .updateSelectedCity(value),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 200.ah),
          RexFlatButton(
            onPressed: () =>
                ref.watch(cardNotifier.notifier).validateRequestCard(context),
            buttonTitle: StringAssets.continueTextOnButton,
            backgroundColor: AppColors.rexPurpleLight,
          ),
        ],
      ),
      /*bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () =>
                ref.watch(cardNotifier.notifier).validateRequestCard(context),
            buttonTitle: StringAssets.continueTextOnButton,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),*/
    );
  }
}
