import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/ui_widgets/uptime_data_widget.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/bank_uptime_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BankUptimeScreen extends ConsumerStatefulWidget {
  const BankUptimeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BankUptimeScreenState();
}

class _BankUptimeScreenState extends ConsumerState<BankUptimeScreen> {
  late final TextEditingController controller;
  String _query = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(_handleSearchChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_handleSearchChanged);
    controller.dispose();
    super.dispose();
  }

  void _handleSearchChanged() {
    final currentQuery = controller.text.trim().toLowerCase();
    if (currentQuery != _query) {
      setState(() {
        _query = currentQuery;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final uptime = ref.watch(bankUptimeProvider);
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.symmetric(horizontal: 4.aw),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: Strings.uptimeScreenTitle,
        subtitle: Strings.uptimeScreenSubtitle,
      ),
      body: uptime.when(
        data: (uptimeRes) {
          final query = _query;
          final List<UptimeData> filteredBanks =
              query.isEmpty
                  ? List<UptimeData>.of(uptimeRes.data)
                  : uptimeRes.data
                      .where((t) => t.bankName.toLowerCase().contains(query))
                      .toList(growable: false);
          //
          return Column(
            children: [
              UptimeDataSearchField(controller: controller),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(16.ar),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.ar),
                  ),
                  child:
                      filteredBanks.isEmpty
                          ? UptimeSearchEmpty()
                          : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: filteredBanks.length,
                            itemBuilder: (context, index) {
                              return UptimeDataWidget(
                                uptimeData: filteredBanks[index],
                              );
                            },
                          ),
                ),
              ),
            ],
          );
        },
        error: (_, v) => Center(child: const Text(Strings.uptimeError)),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
