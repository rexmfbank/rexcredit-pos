// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rex_app/src/config/routes/route_name.dart';
// import 'package:rex_app/src/modules/shared/widgets/custom_option_with_icon_item_widget.dart';
// import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
// import 'package:rex_app/src/utils/constants/string_assets.dart';

// class InvestmentTypeScreen extends HookConsumerWidget {
//   const InvestmentTypeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: const RexAppBar(
//         step: null,
//         shouldHaveBackButton: true,
//         title: 'Investment',
//         subtitle: StringAssets.createSavingsPlanSubtitle,
//       ),
//       body: ListView(
//         children: [
//           InvestmentTypeCard(
//             iconPath: 'assets/png/fixed_deposit_icon.png',
//             investmentTitle: 'Fixed Deposit',
//             investmentSubTitle: 'Add fixed deposit',
//             onTap: () {
//               context.push(
//                   '${RouteName.dashboardSave}/${RouteName.fixedDeposits}');
//             },
//           ),
//           const SizedBox(height: 16.0),
//           InvestmentTypeCard(
//             iconPath: 'assets/png/target_savings_icon.png',
//             investmentTitle: 'Target Savings',
//             investmentSubTitle:
//                 'Add card to start autosaving at preferred frequency',
//             onTap: () {
//               context.push(
//                   '${RouteName.dashboardSave}/${RouteName.targetSavings}');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
