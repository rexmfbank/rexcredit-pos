import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/pos_device/model/pos_type.dart';
import 'package:rex_app/src/modules/quick_purchase/ui/purchase_status_screen_body.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/amount_widget.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/amount_widget_topwise.dart';
import 'package:rex_app/src/modules/quick_purchase/provider/pos_card_purchase_provider.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/modules/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/shared/page_widgets/app_scaffold.dart';

class QuickPurchaseScreen extends ConsumerStatefulWidget {
  const QuickPurchaseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickPurchaseScreenState();
}

class _QuickPurchaseScreenState extends ConsumerState<QuickPurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(posCardPurchaseProvider);
    return state.hasReturn
        ? PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              ref.read(posCardPurchaseProvider.notifier).clearState();
            }
          },
          child: AppScaffold(
            isLoading: state.isLoading,
            body:
                state.isTsqChecking
                    ? Center(child: Text("Confirming Status"))
                    : PurchaseStatusScreenBody(),
          ),
        )
        : QuickPurchaseScreenBody();
  }

  /*@override
  Widget build(BuildContext context) {
    final baseAppName = AppKeysStorage.getConfig().baseappName;
    final state = ref.watch(posCardPurchaseProvider);
    return Pkg.isTopwise(baseAppName)
        ? AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: AppbarSubScreen(title: 'Enter Amount'),
          body: AmountWidgetTopwise(isQuickPurchase: true),
        )
        : AppScaffold(
          isLoading: state.isLoading,
          padding: EdgeInsets.all(0),
          appBar: AppbarSubScreen(title: 'Enter Amount'),
          body: AmountWidget(isQuickPurchase: true),
        );
  }*/
}

class QuickPurchaseScreenBody extends ConsumerWidget {
  const QuickPurchaseScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final baseAppName = ref.read(baseAppNameProvider);
    final state = ref.watch(posCardPurchaseProvider);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(posCardPurchaseProvider.notifier).clearState();
        }
      },
      child: AppScaffold(
        isLoading: state.isLoading,
        padding: EdgeInsets.all(0),
        appBar: AppbarSubScreen(
          title: 'Enter Amount',
          onBackBtnPress: () {
            ref.read(posCardPurchaseProvider.notifier).clearState();
            context.pop();
          },
        ),
        body:
            state.baseappName == Pkg.topwise ||
                    state.baseappName == Pkg.topwise2
                ? AmountWidgetTopwise(isQuickPurchase: true)
                : AmountWidget(isQuickPurchase: true),
      ),
    );
  }
}
