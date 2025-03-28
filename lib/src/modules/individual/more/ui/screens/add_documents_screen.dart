import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/provider/additional_documents_provider.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/add_docs_id_card_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/ui/components/add_docs_utility_dropdown.dart';
import 'package:rex_app/src/modules/individual/more/update_account/kyc_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/upload_document_widget.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/doc_type.dart';

class AddDocumentsScreen extends HookConsumerWidget {
  const AddDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDocument = ref.watch(selectedKycDocumentProvider);

    //
    return AppScaffold(
      isLoading: ref.watch(kycNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.addDocumentScreenTitle,
        subtitle: StringAssets.addDocumentScreenSubtitle,
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 15.ah),
              selectedDocument?.documentType ==
                      DocType.identitydocument.jsonString
                  ? const AddDocsIdCardDropdown(padding: EdgeInsets.zero)
                  : const AddDocsUtilityDropdown(padding: EdgeInsets.zero),
              SizedBox(height: 15.ah),
              selectedDocument?.referenceNoRequired == 'Y'
                  ? RexTextField(
                horizontalPadding: 0,
                      showOuterTile: true,
                      outerTitle: selectedDocument?.referenceNoTitle,
                      hintText: StringAssets.cardNumberHint,
                      controller: ref.watch(kycNotifier).referenceController,
                      obscureText: false,
                    )
                  : Container(),
              SizedBox(height: 25.ah),
              UploadDocumentWidget(
                title: selectedDocument?.documentText ??
                    StringAssets.uploadDocument,
                onUpload: (value)=> ref.watch(kycNotifier.notifier).updateFileDetails(value),
              ),
              RexElevatedButton(
                onPressed: () =>
                    ref.watch(kycNotifier.notifier).validateUpload(
                          context: context,      
                          referenceRequired:
                              selectedDocument?.referenceNoRequired == 'Y',
                        ),
                buttonTitle: StringAssets.confirmTextOnButton,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
