import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/transfer/external_transfer_screen.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/transfer/widgets/transfer_tab_bar.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui/rex_transfer_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TransfersPage extends ConsumerStatefulWidget {
  const TransfersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransfersPageState();
}

class _TransfersPageState extends ConsumerState<TransfersPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(homeTransferNotifier);
    final tabController = transferState.transferTabController;

    return AppScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexBackground,
      isLoading: transferState.isLoading,
      padding: EdgeInsets.all(0),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppColors.rexBackgroundGrey,
                  expandedHeight: 125,
                  collapsedHeight: 120,
                  toolbarHeight: 0,
                  pinned: false,
                  flexibleSpace: const CustomAppBar(
                    shouldHaveBackButton: true,
                    showNotification: false,
                    showImage: false,
                    showAccountBalance: true,
                    title: StringAssets.transferMoney,
                    subtitle: StringAssets.toRexAccountOrOthers,
                    height: 125,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: false,
                  delegate: _SliverTabBarDelegate(const TransferTabBar()),
                ),
              ],
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [ExternalTransferScreen(), const RexTransferScreen()],
          ),
        ),
      ),
    );
  }
}

/// Helper delegate to embed a normal widget (the tab bar) as a sliver header
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  const _SliverTabBarDelegate(this._child);

  final Widget _child;

  @override
  double get minExtent =>
      _child is PreferredSizeWidget
          ? (_child).preferredSize.height
          : kToolbarHeight;

  @override
  double get maxExtent => minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _child;
  }

  @override
  bool shouldRebuild(covariant _SliverTabBarDelegate oldDelegate) => false;
}

/*class _TransfersPageState extends ConsumerState<TransfersPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(homeTransferNotifier).isLoading,
      appBar: const CustomAppBar(
        shouldHaveBackButton: true,
        showNotification: false,
        showImage: false,
        showAccountBalance: true,
        title: StringAssets.transferMoney,
        subtitle: StringAssets.toRexAccountOrOthers,
        height: 160,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TransferTabBar(),
            SizedBox(height: 8.ah),
            Flexible(
              flex: 1,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller:
                    ref.watch(homeTransferNotifier).transferTabController,
                children: [ExternalTransferScreen(), const RexTransferScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
