import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/purchase/ui/quick_purchase_option_screen.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class LoginPurchaseOptionScreen extends ConsumerWidget {
  const LoginPurchaseOptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      appBar: AppbarSubScreen(title: 'Select Action', centerTitle: true),
      backgroundColor: AppColors.rexBackground,
      body: PurchaseOptionScreenBody(outside: true),
    );
  }
}
