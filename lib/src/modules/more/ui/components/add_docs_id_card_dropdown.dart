import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/more/models/document_type.dart';
import 'package:rex_app/src/modules/more/ui/components/id_card_dropdown_header.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AddDocsIdCardDropdown extends ConsumerWidget {
  final EdgeInsets? padding;
  const AddDocsIdCardDropdown({super.key, this.padding});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const document = [
      DocumentType(
          id: 1,
          documentId: 101,
          name: 'International Passport',
          status: true,
          createdAt: ''),
      DocumentType(
          id: 2,
          documentId: 102,
          name: 'Drivers License',
          status: false,
          createdAt: ''),
      DocumentType(
          id: 3,
          documentId: 103,
          name: 'Voter\'s Card',
          status: false,
          createdAt: ''),
      DocumentType(
          id: 4,
          documentId: 104,
          name: 'National ID/NIN',
          status: false,
          createdAt: ''),
    ];
    //
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const IdCardDropdownHeader(),
        SizedBox(height: 7.ah),
        Padding(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.aw),
          child: Container(
              decoration: BoxDecoration(
                color: AppColors.rexWhite,
                borderRadius: BorderRadius.circular(14.ar),
              ),
              child: DropdownButtonFormField(
                items: document.map<DropdownMenuItem<DocumentType>>((docType) {
                  return DropdownMenuItem(
                    value: docType,
                    child: Text(docType.name),
                  );
                }).toList(),
                onChanged: (DocumentType? value) {},
                decoration: InputDecoration(
                  focusColor: Colors.black,
                  border: rexInputBorder,
                  enabledBorder: rexInputBorder,
                  focusedBorder: rexInputBorder,
                ),
                isExpanded: true,
              )),
        ),
      ],
    );
  }
}
