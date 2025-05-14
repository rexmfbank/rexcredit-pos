import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_application_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_product_type_item_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class IndividualLoanEmployeeTypeScreen extends ConsumerWidget {
  const IndividualLoanEmployeeTypeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.employeeTitle,
        subtitle: StringAssets.employeeSubtitle,
      ),
      body: ListView(
        children: [
          CustomTypeItemCard(
            title: 'Private Sector',
            subTitle: 'I work in a private sector',
            onTap: () {
              context
                  .push('${Routes.dashboardBorrow}/${Routes.individualBorrow}');
            },
          ),
          const SizedBox(height: 16.0),
          CustomTypeItemCard(
            title: 'Public Sector',
            subTitle: 'I work in a public sector',
            onTap: () {
              ref
                  .read(loanApplicationProvider.notifier)
                  .fetchPublicAgencies(context);
              ref.read(loanApplicationProvider.notifier).setSelectedState = "";
              ref.read(loanApplicationProvider.notifier).setSelectedAgency = "";
              context
                  .push('${Routes.dashboardBorrow}/${Routes.listOfAgencies}');
            },
          ),
        ],
      ),
    );
  }
}
