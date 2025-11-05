import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/empty_beneficiary_list.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/bank_list_item.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BankList extends ConsumerStatefulWidget {
  final Function(BankData) onClick;
  const BankList({super.key, required this.onClick});

  @override
  ConsumerState<BankList> createState() => _BankListState();
}

class _BankListState extends ConsumerState<BankList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeTransferNotifier.notifier).getListOfBanks(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppConstants.deviceHeight - 70.ah,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 24.ah),
          Padding(
            padding: EdgeInsets.only(left: 16.aw),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Bank",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 16.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexSearchField(
              controller: ref.watch(homeTransferNotifier).bankSearchController,
              hint: Strings.searchForBanks2,
              onChanged:
                  (value) => ref
                      .watch(homeTransferNotifier.notifier)
                      .filterBanks(value),
              hintStyle: AppTextStyles.body2Regular.copyWith(
                color: AppColors.rexTint500,
                fontSize: 13.asp,
              ),
              enabledBorderColor: AppColors.rexPurpleLight,
              borderRadius: 15.ar,
            ),
          ),
          Builder(
            builder: (context) {
              List<BankData> data =
                  (ref.watch(homeTransferNotifier).banks.isNotEmpty)
                      ? (ref.watch(homeTransferNotifier).banks..removeWhere(
                        (element) =>
                            element.name.isBlank || element.code.isBlank,
                      ))
                      : [];
              if (data.isEmpty && !ref.watch(homeTransferNotifier).isLoading) {
                return const EmptyBeneficiaryList();
              }
              if (data.isEmpty && ref.watch(homeTransferNotifier).isLoading) {
                return Column(
                  children: [
                    SizedBox(height: 80.ah),
                    SizedBox(
                      height: 60.ah,
                      width: 60.aw,
                      child: const CircularProgressIndicator(
                        color: AppColors.rexPurpleLight,
                      ),
                    ),
                  ],
                );
              }
              return Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return BankListItem(
                      onTap: () => widget.onClick.call(data[index]),
                      bankName: data[index].name,
                      bankUptimeNo: data[index].bankUptime,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 2.ah),
                  itemCount: data.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
