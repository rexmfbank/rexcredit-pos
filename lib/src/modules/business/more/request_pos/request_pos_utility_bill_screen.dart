import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/providers/request_pos_state_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/custom_upload_document_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestPosUtilityBillScreen extends ConsumerWidget {
  const RequestPosUtilityBillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: const RexAppBar(
          step: null,
          shouldHaveBackButton: true,
          title: StringAssets.utilityBillTitle2,
          subtitle: StringAssets.utilityBillSubtitle,
          hasActionButton: false,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16),
            const RexCustomSpinner(
                options: ['LAWMA', 'Electricity'],
                title: StringAssets.selectUtilityBillType),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text(
                StringAssets.uploadImageBill,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.rexPurpleDark,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: UploadDocumentWidget(
                fileTypes: StringAssets.docType,
                onTap: () {},
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  ref.read(posRequestUtilityBillProvider.notifier).state = true;
                  context.pop();
                },
                buttonTitle: StringAssets.saveAndContinueText,
                backgroundColor: null,
              ),
            ),
          ],
        ));
  }
}
