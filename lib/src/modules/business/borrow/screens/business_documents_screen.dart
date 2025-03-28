import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_board_resolution_upload.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_cac_certificate_upload.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

class BusinessDocumentsScreen extends ConsumerWidget {
  const BusinessDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Business documents',
        subtitle:
            'Please upload all necessary registration documents for your company',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          const BusinessCacCertificateUpload(),
          const SizedBox(height: 10),
          const BusinessBoardResolutionUpload(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
              left: 14.0,
              right: 14.0,
            ),
            child: RexElevatedButton(
              onPressed: () {
                context.go(
                  "${RouteName.dashboardBorrowBusiness}/${RouteName.businessLoanSubmit}",
                );
              },
              buttonTitle: 'Save & Continue',
              backgroundColor: null,
            ),
          ),
        ],
      ),
    );
  }
}
