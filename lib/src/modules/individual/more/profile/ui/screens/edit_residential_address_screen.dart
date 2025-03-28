import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/update_residential_address_provider.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/add_docs_upload_image.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../../utils/mixin/locator_mixin.dart';
import '../../../../../shared/widgets/custom_spinner.dart';

class EditResidentialAddressScreen extends ConsumerStatefulWidget
    with LocatorMix {
  const EditResidentialAddressScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditResidentialAddressScreenState();
}

class _EditResidentialAddressScreenState
    extends ConsumerState<EditResidentialAddressScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(updateResidentialAddressProvider.notifier).fetchStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.editResidentialAddress,
        subtitle: StringAssets.editResidentialAddressSubtitle,
      ),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 8.ah),
          child: ListView(
            children: [
              const ImageUploadWidget(
                title: StringAssets.uploadImageofUtilityBill,
              ),
              SizedBox(height: 16.0.ah),
              RexTextField(
                outerTitle: StringAssets.houseNumberTitle,
                hintText: StringAssets.houseNumberHint,
                showOuterTile: true,
                controller: ref
                    .watch(updateResidentialAddressProvider)
                    .houseNumberController,
                validator: (value) => TextfieldValidator.name(value),
                textFieldIsRequired: true,
              ),
              RexTextField(
                outerTitle: StringAssets.streetTitle,
                hintText: StringAssets.streetHint,
                showOuterTile: true,
                controller: ref
                    .watch(updateResidentialAddressProvider)
                    .streetController,
                validator: (value) => TextfieldValidator.name(value),
                inputType: TextInputType.streetAddress,
                textFieldIsRequired: true,
              ),
              RexTextField(
                outerTitle: StringAssets.areaTitle,
                hintText: StringAssets.areaHint,
                showOuterTile: true,
                controller:
                    ref.watch(updateResidentialAddressProvider).areaController,
                validator: (value) => TextfieldValidator.name(value),
                inputType: TextInputType.streetAddress,
                textFieldIsRequired: true,
              ),
              RexTextField(
                outerTitle: StringAssets.city,
                hintText: StringAssets.cityHint,
                showOuterTile: true,
                controller: ref
                    .watch(updateResidentialAddressProvider)
                    .addressController,
                validator: (value) => TextfieldValidator.name(value),
                textFieldIsRequired: false,
              ),
              SizedBox(height: 16.0.ah),
              RexCustomSpinner(
                title: StringAssets.state,
                options: ref
                    .watch(updateResidentialAddressProvider)
                    .nigeriaStates
                    .map((e) => e.state.name)
                    .toList(),
                onOptionChanged: (p0) {
                  ref
                      .read(updateResidentialAddressProvider.notifier)
                      .setSelectedState = p0!;
                },
              ),
              SizedBox(height: 16.0.ah),
              RexCustomSpinner(
                title: StringAssets.lga,
                options: ref
                        .watch(updateResidentialAddressProvider)
                        .selectedNigeriaState
                        .isBlank
                    ? []
                    : ref
                        .watch(updateResidentialAddressProvider)
                        .nigeriaStates
                        .firstWhere((element) =>
                            element.state.name ==
                            ref
                                .watch(updateResidentialAddressProvider)
                                .selectedNigeriaState)
                        .state
                        .locals,
                onOptionChanged: (p0) {
                  ref
                      .read(updateResidentialAddressProvider.notifier)
                      .setSelectedLGA = p0!;
                },
              ),
              SizedBox(height: 8.ah),
              Padding(
                padding: EdgeInsets.all(16.0.ar),
                child: RexElevatedButton(
                  onPressed: () {
                    ref
                        .read(updateResidentialAddressProvider.notifier)
                        .validateInputAndProceed(context);
                  },
                  buttonTitle: StringAssets.saveTextOnButton,
                  backgroundColor: null,
                ),
              ),
            ],
          ),
        ),
        ref.watch(updateResidentialAddressProvider).isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container()
      ]),
    );
  }
}
