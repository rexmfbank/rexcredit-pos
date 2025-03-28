import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/providers/request_pos_state_providers.dart';
import 'package:rex_app/src/modules/individual/more/provider/request_pos_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestPosScreen extends ConsumerWidget {
  const RequestPosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDirectorIDCompleted = ref.watch(directorIDProvider);
    final bool isUtilityBillCompleted =
        ref.watch(posRequestUtilityBillProvider);
    final bool isCacDocumentCompleted =
        ref.watch(posRequestCacDocumentProvider);

    return Scaffold(
        appBar: const RexAppBar(
          step: null,
          shouldHaveBackButton: true,
          title: StringAssets.requestPosTitle,
          subtitle: StringAssets.requestPosSubtitle,
          hasActionButton: false,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 16),
            // RexListTile(
            //   leadingWidget: isDirectorIDCompleted
            //       ? Image.asset('assets/png/card_tick_brown.png')
            //       : Image.asset('assets/png/card_tick.png'),
            //   title: StringAssets.directorIdVerification,
            //   subtitle: StringAssets.directorIdVerificationSubtitle,
            //   hasTrailingIcon: true,
            //   onTap: () {
            //     context.push(
            //       "${RouteName.dashboardMoreBusiness}/${RouteName.directorsIdVerification}",
            //     );
            //   },
            //   verifiedField: isDirectorIDCompleted,
            // ),
            // RexListTile(
            //   leadingWidget: isUtilityBillCompleted
            //       ? Image.asset('assets/png/document_brown.png')
            //       : Image.asset('assets/png/document.png'),
            //   title: 'Utility bill',
            //   subtitle: 'Upload a recent utility bill',
            //   hasTrailingIcon: true,
            //   onTap: () {
            //     context.push(
            //         '${RouteName.dashboardMoreBusiness}/${RouteName.requestPosUtilityBill}');
            //   },
            //   verifiedField: isUtilityBillCompleted,
            // ),
            // RexListTile(
            //   leadingWidget: isCacDocumentCompleted
            //       ? Image.asset('assets/png/document_brown.png')
            //       : Image.asset('assets/png/document.png'),
            //   title: StringAssets.cacDocument,
            //   subtitle: StringAssets.cacDocumentSubtitle,
            //   hasTrailingIcon: true,
            //   onTap: () {
            //     context.push(
            //       "${RouteName.dashboardMoreBusiness}/${RouteName.requestPosCACDocument}",
            //     );
            //   },
            //   verifiedField: isCacDocumentCompleted,
            // ),
            RexTextField(
              outerTitle: StringAssets.contactPerson,
              hintText: StringAssets.enterContactPerson,
              controller: ref.watch(requestPOSProvider).contactPersonController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.text,
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.input(value),
            ),
            RexTextField(
              outerTitle: StringAssets.lineOfBusiness,
              hintText: StringAssets.lineOfBusinessHint,
              controller:
                  ref.watch(requestPOSProvider).lineOfBusinessController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.text,
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.input(value),
            ),
            RexTextField(
              outerTitle: StringAssets.settlementAccountName,
              hintText: StringAssets.settlementAccountNameHint,
              controller:
                  ref.watch(requestPOSProvider).settlementAccountNameController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.text,
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.input(value),
            ),
            RexTextField(
              outerTitle: StringAssets.settlementAccountNumber,
              hintText: StringAssets.settlementAccountNumberHint,
              controller: ref
                  .watch(requestPOSProvider)
                  .settlementAccountNumberController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.number,
              hasInputFormat: false,
              validator: (value) => TextfieldValidator.input(value),
            ),
            RexTextField(
              outerTitle: StringAssets.settlementBankName,
              hintText: StringAssets.settlementBankNameHint,
              controller:
                  ref.watch(requestPOSProvider).settlementBankNameController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.text,
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.input(value),
            ),
            RexTextField(
              outerTitle: StringAssets.posAddressTitle,
              hintText: StringAssets.posAddressHint,
              controller:
                  ref.watch(requestPOSProvider).physicalAddressController,
              obscureText: false,
              showOuterTile: true,
              inputType: TextInputType.text,
              hasInputFormat: true,
              validator: (value) => TextfieldValidator.input(value),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  ref
                      .read(requestPOSProvider.notifier)
                      .validateBusinessPosRequestDetails(context);
                },
                buttonTitle: StringAssets.submitTextOnButton,
                backgroundColor: AppColors.rexLightBlue2,
                borderColor: AppColors.rexLightBlue2,
              ),
            ),
            const SizedBox(height: 40),
            // Padding(
            //   padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            //   child: RexFlatButton(
            //     onPressed: () {
            //       if (isCacDocumentCompleted &&
            //           isDirectorIDCompleted &&
            //           isUtilityBillCompleted) {
            //         showModalActionSuccess(
            //             context: context,
            //             subtitle: StringAssets.requestPosSuccess,
            //             title: StringAssets.requestSubmitted,
            //             onPressed: () {
            //               context.pop();
            //               context.pop();
            //             });
            //       }
            //     },
            //     buttonTitle: StringAssets.submitTextOnButton,
            //     backgroundColor: AppColors.rexLightBlue2,
            //     borderColor: AppColors.rexLightBlue2,
            //   ),
            // ),
          ],
        ));
  }
}
