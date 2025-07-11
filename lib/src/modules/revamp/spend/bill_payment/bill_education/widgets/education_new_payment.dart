import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_education/widgets/education_biller_dropdown.dart';
import 'package:rex_app/src/modules/revamp/spend/bill_payment/bill_education/widgets/education_plan_dropdown.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EducationNewPayment extends HookConsumerWidget {
  const EducationNewPayment({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionController = useTextEditingController();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const EducationBillerDropdown(),
          const EducationPlanDropdown(),
          RexTextField(
            outerTitle: 'Enter meter number',
            hintText: '',
            controller: transactionController,
            obscureText: false,
          ),
          RexElevatedButton(
            onPressed: () {
              context.push(
                  "${Routes.dashboardSpend}/${Routes.billEducationConfirm}");
            },
            buttonTitle: StringAssets.nextTextOnButton,
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}
