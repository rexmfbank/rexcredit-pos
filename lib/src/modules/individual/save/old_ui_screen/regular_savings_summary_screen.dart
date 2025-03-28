// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rex_app/src/modules/individual/save_new/old_ui_components/fund_plan_bottom_sheet.dart';
// import 'package:rex_app/src/modules/individual/save_new/old_ui_components/regular_savings_summary_card.dart';
// import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
// import 'package:rex_app/src/modules/shared/providers/logger_provider.dart';
// import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
// import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
// import 'package:rex_app/src/utils/constants/string_assets.dart';
// import 'package:rex_app/src/utils/currency.dart';

// class RegularSavingsSummaryScreen extends ConsumerWidget {
//   const RegularSavingsSummaryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final logger = ref.watch(loggerProvider);

//     int savingsPlanId = 0;

//     return Scaffold(
//       appBar: const RexAppBar(
//         step: null,
//         shouldHaveBackButton: true,
//         title: StringAssets.regularSavingsAppBarTitle,
//         subtitle: StringAssets.savingsPlanSubtitle,
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(height: 32),
//           RegularSavingsSummaryCard(
//             amountToSave: addNairaCurrencySymbol('0.00'),
//             interestRate: '',
//             savingsTenor: '',
//             frequency: '',
//             autosave: 'No',
//           ),
//           const SizedBox(height: 32),
//           Padding(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//             child: RexFlatButton(
//               onPressed: () {
//                 // num amountToPay = double.parse(
//                 //     planSummaryData.amountToSave!.replaceAll(",", ""));
//                 // logger.d("Amount to pay: $amountToPay");

//                 // final authToken = ref.watch(userAuthTokenProvider) ?? 'null';

//                 showFundPlanBottomSheet(
//                     context: context,
//                     amountToPay: 9000.0,
//                     isTopUp: false,
//                     id: 1);
//               },
//               buttonTitle: StringAssets.fundRegularSavingsPlanTextOnButton,
//               backgroundColor: null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
