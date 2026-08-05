import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/pos_list_tile.dart';

class QuickPurchaseOptionScreen extends ConsumerWidget {
  const QuickPurchaseOptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Select Action', centerTitle: true),
      backgroundColor: AppColors.rexBackground,
      body: PurchaseOptionScreenBody(outside: false),
    );
  }
}

class PurchaseOptionScreenBody extends ConsumerStatefulWidget {
  const PurchaseOptionScreenBody({super.key, required this.outside});

  final bool outside;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PurchaseOptionScreenBodyState();
}

class _PurchaseOptionScreenBodyState
    extends ConsumerState<PurchaseOptionScreenBody> {
  @override
  Widget build(BuildContext context) {
    //
    ref.listen(posCardPurchaseProvider, (previous, next) {
      if (next.cardBalanceReturns && !(previous?.cardBalanceReturns ?? false)) {
        showAppDialogCardBalance(
          context: context,
          statusCode: next.cardBalanceStatusCode,
          amount: next.cardBalanceAmount,
          onPressed: () {
            ref.read(posCardPurchaseProvider.notifier).resetCardBalance();
            context.pop();
          },
        );
      }
    });
    //
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 0.0),
      child: ListView(
        children: [
          SizedBox(height: 16),
          PosListTile(
            title: 'Card Purchase',
            iconPath: AssetPath.iconCardPurchase,
            iconBgColor: Color(0xffEFF3FF),
            onTap: () {
              ref.read(posCardPurchaseProvider.notifier).initializeData();
              if (widget.outside) {
                context.push(Routes.loginPurchaseScreenPath);
              } else {
                context.push(Routes.quickPurchaseScreen);
              }
            },
          ),
          SizedBox(height: 16),
          PosListTile(
            title: 'Check Card Balance',
            iconPath: AssetPath.iconCardBalance,
            iconBgColor: Color(0xffFFF7EB),
            onTap: () {
              ref.read(posCardPurchaseProvider.notifier).doCheckBalance();
            },
          ),
        ],
      ),
    );
  }
}
