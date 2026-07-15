import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_int_provider.dart';
import 'package:rex_app/src/modules/transfer/transfer_external_screen.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/transfer_internal_screen.dart';
import 'package:rex_app/src/modules/transfer/widgets/custom_appbar.dart';
import 'package:rex_app/src/modules/transfer/widgets/transfer_tab_bar.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class TransfersPage extends ConsumerStatefulWidget {
  const TransfersPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransfersPageState();
}

class _TransfersPageState extends ConsumerState<TransfersPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(transferExtProvider);
    final transferIntState = ref.watch(transferIntProvider);
    final tabController = transferState.transferTabController;

    return AppScaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.rexBackground,
      isLoading: transferState.isLoading || transferIntState.isLoading,
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
                    title: Strings.transferMoney,
                    subtitle: Strings.toRexAccountOrOthers,
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
            children: [
              ExternalTransferScreen(),
              const InternalTransferScreen(),
            ],
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
