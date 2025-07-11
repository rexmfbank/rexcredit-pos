import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/components/uptime_data_widget.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/bank_uptime_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BankUptimeScreen extends ConsumerWidget {
  const BankUptimeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uptime = ref.watch(bankUptimeProvider);
    return AppScaffold(
      padding: EdgeInsets.symmetric(horizontal: 4.aw),
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.uptimeScreenTitle,
        subtitle: StringAssets.uptimeScreenSubtitle,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.aw, top: 8.ah, right: 16.aw),
              child: Text(
                StringAssets.uptimeBodyTitle,
                style: AppTextStyles.body2Regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.rexTint400,
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              margin: EdgeInsets.all(16.ar),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.ar),
              ),
              child: uptime.when(
                data: (uptimeRes) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: uptimeRes.data.length,
                    itemBuilder: (context, index) {
                      return UptimeDataWidget(
                        bankName: uptimeRes.data[index].bankName,
                        percent: uptimeRes.data[index].uptimePercent,
                      );
                    },
                  );
                },
                error: (err, _) => const Text(StringAssets.uptimeError),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
