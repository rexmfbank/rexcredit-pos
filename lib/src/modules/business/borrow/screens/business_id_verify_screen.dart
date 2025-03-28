import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_id_card_dropdown.dart';
import 'package:rex_app/src/modules/business/borrow/components/business_id_card_upload.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessIdVerifyScreen extends StatefulHookConsumerWidget {
  const BusinessIdVerifyScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessIdVerifyScreenState();
}

class _BusinessIdVerifyScreenState
    extends ConsumerState<BusinessIdVerifyScreen> {
  @override
  Widget build(BuildContext context) {
    final idCardController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'ID Verification',
        subtitle:
            'Please upload all necessary registration documents for your company',
      ),
      body: ListView(
        children: [
          const BusinessIdCardDropdown(),
          RexTextField(
            outerTitle: 'Identity Card number',
            hintText: '',
            controller: idCardController,
            obscureText: false,
            showOuterTile: true,
          ),
          const BusinessIdCardUpload(),
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
