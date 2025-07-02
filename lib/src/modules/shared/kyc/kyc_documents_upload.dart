import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/add_docs_id_card_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/add_docs_utility_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/upload_document_widget.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/doc_type.dart';

class KycDocumentsUpload extends ConsumerWidget {
  final KycDocInfo kycInfo;
  const KycDocumentsUpload({super.key, required this.kycInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(kycNotifier).isLoading,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.uploadDocumentText,
        subtitle: StringAssets.uploadDocumentSubText,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (kycInfo.documentType == DocType.identitydocument.jsonString) ...[
            SizedBox(height: 15.ah),
            const AddDocsIdCardDropdown(padding: EdgeInsets.zero),
          ],
          if (kycInfo.documentType == DocType.utility.jsonString) ...[
            SizedBox(height: 15.ah),
            const AddDocsUtilityDropdown(padding: EdgeInsets.zero),
          ],
          if (kycInfo.referenceNoRequired == 'Y') ...[
            SizedBox(height: 15.ah),
            RexTextField(
              horizontalPadding: 0,
              outerTitle: kycInfo.referenceNoTitle,
              showOuterTile: true,
              hintText: StringAssets.referenceNumberHint,
              controller: ref.watch(kycNotifier).referenceController,
              obscureText: false,
            ),
          ],
          SizedBox(height: 25.ah),
          UploadDocumentWidget(
            title: kycInfo.documentText ?? StringAssets.uploadDocument,
            onUpload: (value) =>
                ref.watch(kycNotifier.notifier).updateFileDetails(value),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () => ref.watch(kycNotifier.notifier).validateUpload(
                  context: context,
                  referenceRequired: kycInfo.referenceNoRequired == 'Y',
                ),
            buttonTitle: StringAssets.submitTextOnButton,
            backgroundColor: null,
          ),
          SizedBox(height: 30.ah),
        ],
      ),
    );
  }
}
