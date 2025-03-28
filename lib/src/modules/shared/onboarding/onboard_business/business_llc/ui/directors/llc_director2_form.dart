// ignore_for_file: camel_case_types

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/provider/llc_director_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LLC_Director2Form extends StatefulHookConsumerWidget {
  const LLC_Director2Form({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LLC_Director2FormState();
}

class _LLC_Director2FormState extends ConsumerState<LLC_Director2Form> {
  bool tileExpanded = false;

  @override
  Widget build(BuildContext context) {
    final directorInfo = ref.watch(llcDirectorProvider);
    //
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: const Text(StringAssets.addDirectorForm2),
        onExpansionChanged: (bool expanded) {
          setState(() {
            tileExpanded = expanded;
          });
        },
        children: [
          RexTextField(
            outerTitle: StringAssets.firstNameTitle,
            hintText: '',
            controller: directorInfo.director2FirstName,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.name(value),
            inputType: TextInputType.name,
            textFieldIsRequired: true,
          ),
          RexTextField(
            outerTitle: StringAssets.middleNameTitle,
            hintText: '',
            controller: directorInfo.director2MiddleName,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.name(value),
            inputType: TextInputType.name,
          ),
          RexTextField(
            outerTitle: StringAssets.lastNameTitle,
            hintText: '',
            controller: directorInfo.director2LastName,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.name(value),
            inputType: TextInputType.name,
            textFieldIsRequired: true,
          ),
          RexTextField(
            outerTitle: StringAssets.emailAddressTitle,
            hintText: '',
            controller: directorInfo.director2Email,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.email(value),
            inputType: TextInputType.emailAddress,
            textFieldIsRequired: true,
          ),
          RexTextField(
            outerTitle: StringAssets.phoneNumberTitle,
            hintText: '',
            controller: directorInfo.director2Mobile,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.phoneNumber(value),
            inputType: TextInputType.phone,
            textFieldIsRequired: true,
            maxLength: 11,
          ),
          RexTextField(
            outerTitle: StringAssets.bvnTitle,
            hintText: '',
            controller: directorInfo.director2BVN,
            obscureText: false,
            showOuterTile: true,
            validator: (value) => TextfieldValidator.bvn(value),
            inputType: TextInputType.number,
            textFieldIsRequired: true,
            maxLength: 11,
          ),
          RexTextField(
            outerTitle: StringAssets.sharesOwned2,
            hintText: '',
            controller: directorInfo.director2Shares,
            obscureText: false,
            showOuterTile: true,
            inputType: TextInputType.number,
            textFieldIsRequired: true,
          ),
          // const BusinessDirectorIdCardDropdown(),
          // const BusinessDirectorIdUpload(),
        ],
      ),
    );
  }
}
