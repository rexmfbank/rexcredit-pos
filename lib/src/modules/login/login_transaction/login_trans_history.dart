// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rex_app/src/modules/api/rex_api.dart';
// import 'package:rex_app/src/modules/login/login_transaction/login_trans_history_item.dart';
// import 'package:rex_app/src/modules/login/provider/user_recent_transaction_provider.dart';
// import 'package:rex_app/src/modules/utils/general/app_strings.dart';
// import 'package:rex_app/src/modules/utils/general/constants.dart';
// import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
// import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

// class LoginTransHistory extends ConsumerStatefulWidget {
//   const LoginTransHistory({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _LoginTransHistoryState();
// }

// class _LoginTransHistoryState extends ConsumerState<LoginTransHistory> {
//   @override
//   Widget build(BuildContext context) {
//     final recentTransact = ref.watch(userRecentTransactionProvider);
//     return AppScaffold(
//       padding: EdgeInsets.all(0),
//       appBar: AppbarSubScreen(title: 'Transaction History', centerTitle: true),
//       body: Column(
//         children: [
//           // TransactionSearchFilter(
//           //   onChangedText: (query) async {
//           //     await ref.read(paginationProvider.notifier).applySearch(query);
//           //   },
//           //   onTap: () {
//           //     showFilterTransaction(
//           //       context: context,
//           //       onClickApply: () {
//           //         _applyFilters();
//           //         context.pop();
//           //       },
//           //       onResetDateFilter: () {
//           //         ref.read(paginationProvider.notifier).refresh();
//           //         context.pop();
//           //       },
//           //     );
//           //   },
//           // ),
//           SizedBox(height: 10),
//           Flexible(
//             fit: FlexFit.loose,
//             child: Container(
//               margin: EdgeInsets.all(16.ar),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.ar),
//               ),
//               child: recentTransact.when(
//                 data: (TData tData) {
//                   if (tData.transactions == null) {
//                     return const TransText(text: Strings.getTransErr);
//                   }
//                   if (tData.transactions!.data.isEmpty) {
//                     return const TransText(text: Strings.noTransactions);
//                   }
//                   return ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: tData.transactions!.data.length,
//                     itemBuilder: (context, index) {
//                       return LoginTransactionHistoryItem(
//                         trans: tData.transactions!.data[index],
//                         canTap: true,
//                       );
//                     },
//                   );
//                 },
//                 error:
//                     (e, _) => Center(
//                       child: Text(
//                         Strings.getTransErr,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                 loading:
//                     () => const Center(
//                       child: CupertinoActivityIndicator(radius: 20.0),
//                     ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TransText extends StatelessWidget {
//   const TransText({super.key, required this.text});
//   final String text;
//   @override
//   Widget build(BuildContext context) => Align(
//     alignment: Alignment.center,
//     child: Text(
//       text,
//       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//     ),
//   );
// }
