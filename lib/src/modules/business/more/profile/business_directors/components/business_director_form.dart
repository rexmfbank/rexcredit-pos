import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/business_director_id_card_dropdown.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/ui/directors/business_director_id_upload.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DirectorForm extends StatefulHookConsumerWidget {
  final GetDirectorsResponseData director;
  final int index;

  const DirectorForm({
    Key? key,
    required this.director,
    required this.index,
  }) : super(key: key);

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() =>
      _BusinessDirectorFormState();
}

class _BusinessDirectorFormState extends ConsumerState<DirectorForm> {
  bool tileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: ExpansionTile(
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Text('${StringAssets.businessDirector} ${widget.index}'),
        onExpansionChanged: (bool expanded) {
          setState(() {
            tileExpanded = expanded;
          });
        },
        children: [
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.firstNameTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.name?.split(" ").first ?? ' ',
            controller: null,
            obscureText: false,
            validator: (value) => TextfieldValidator.name(value),
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.middleNameTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.name!.split(" ").length > 2
                ? widget.director.name?.split(" ")[1]
                : ' ',
            controller: null,
            obscureText: false,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.lastNameTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.name?.split(" ").last ?? ' ',
            controller: null,
            obscureText: false,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.emailAddressTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.email,
            controller: null,
            obscureText: false,
            inputType: TextInputType.emailAddress,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.phoneNumberTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.mobileNo,
            controller: null,
            obscureText: false,
            inputType: TextInputType.phone,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.bvnTitle),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.bvn,
            controller: null,
            obscureText: false,
            inputType: TextInputType.number,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const RexTextFieldRichText(title1: StringAssets.sharesOwned),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            initialValue: widget.director.sharePercent,
            controller: null,
            obscureText: false,
            inputType: TextInputType.number,
            readOnly: true,
          ),
          SizedBox(height: 8.ah),
          const AbsorbPointer(
            child: BusinessDirectorIdCardDropdown(),
          ),
          SizedBox(height: 16.ah),
          const AbsorbPointer(
            child: BusinessDirectorIdUpload(),
          ),
        ],
      ),
    );
  }
}
