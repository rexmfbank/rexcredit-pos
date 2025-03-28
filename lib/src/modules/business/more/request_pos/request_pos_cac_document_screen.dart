import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/providers/request_pos_state_providers.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/custom_upload_document_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestPosCACDocumentsScreen extends ConsumerWidget {
  const RequestPosCACDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: const RexAppBar(
          step: null,
          shouldHaveBackButton: true,
          title: StringAssets.cacDocumentsTitle,
          subtitle: StringAssets.cacDocumentsSubtitle,
          hasActionButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 16),
              const Text(
                StringAssets.uploadCacCert,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark3),
              ),
              const SizedBox(height: 6),
              UploadDocumentWidget(
                fileTypes: StringAssets.docType,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              const Text(
                StringAssets.uploadOtherCacDocs,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark3),
              ),
              const SizedBox(height: 6),
              UploadDocumentWidget(
                fileTypes: StringAssets.docType,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              const Text(
                StringAssets.uploadOtherCacDocs,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.rexPurpleDark3),
              ),
              const SizedBox(height: 6),
              UploadDocumentWidget(
                fileTypes: StringAssets.docType,
                onTap: () {},
              ),
              const SizedBox(height: 18),
              RexFlatButton(
                onPressed: () {
                  ref.read(posRequestCacDocumentProvider.notifier).state = true;
                  context.pop();
                },
                buttonTitle: StringAssets.saveAndContinueText,
                backgroundColor: null,
              ),
            ],
          ),
        ));
  }
}
