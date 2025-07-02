import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class TransactionHistoryScreen extends ConsumerStatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState
    extends ConsumerState<TransactionHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Transaction History'),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (context, index) {
          return TransactionHistoryItem();
        },
      ),
    );
  }
}

class TransactionHistoryItem extends ConsumerWidget {
  const TransactionHistoryItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 8.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("20330319174201011"),
                  Text("Jun 15, 11:40"),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text('₦20000.00'),
                      Text(
                        'Successful',
                        style: TextStyle(color: AppColors.rexGreen),
                      )
                    ],
                  ),
                  Icon(
                    Icons.navigate_next_sharp,
                    color: AppColors.rexBlack,
                  )
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
