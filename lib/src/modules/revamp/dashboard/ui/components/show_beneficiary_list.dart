import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/dashboard/providers/home_transfer_provider.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/empty_beneficiary_list.dart';
import 'package:rex_app/src/modules/revamp/dashboard/ui/components/transfer_beneficiary_item.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_search_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/enums/enums.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BeneficiaryList extends ConsumerWidget {
  const BeneficiaryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: AppConstants.deviceHeight - 70.ah,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 44.ah),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexSearchField(
              controller: ref.watch(homeTransferNotifier).searchController,
              hint: StringAssets.searchForBeneficiaries,
              onChanged: (value) =>
                  ref.watch(homeTransferNotifier.notifier).searchAction(),
              onEditingComplete: (value) => ref
                  .watch(homeTransferNotifier.notifier)
                  .searchBeneficiaries(context: context),
              hintStyle: AppTextStyles.body2Regular.copyWith(
                color: AppColors.rexTint500,
                fontSize: 13.asp,
              ),
              enabledBorderColor: AppColors.rexPurpleLight,
              borderRadius: 15.ar,
            ),
          ),
          ref.watch(homeTransferNotifier).isSearching
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.rexPurpleLight,
                  ),
                )
              : Builder(builder: (context) {
                  List<BeneficiaryData> data = ref
                      .watch(homeTransferNotifier)
                      .beneficiaries
                    ..removeWhere((element) =>
                        element.beneficiaryName.isBlank ||
                        element.beneficiaryAccount.isBlank ||
                        element.finEntityCode.isBlank ||
                        element.finEntityName.isBlank ||
                        element.tranCode !=
                            TransactionCodes.interTransfer.jsonString);
                  if (data.isEmpty) {
                    return const EmptyBeneficiaryList();
                  }
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return TransferBeneficiaryItem(
                          onTap: () => ref
                              .watch(homeTransferNotifier.notifier)
                              .selectBeneficiary(
                                context: context,
                                option: data[index],
                              ),
                          beneficiaryName: data[index].beneficiaryName ?? 'N/A',
                          beneficiaryAccount:
                              data[index].beneficiaryAccount ?? 'N/A',
                          beneficiaryBank:
                              data[index].finEntityName ?? StringAssets.bank,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 2.ah),
                      itemCount: data.length,
                    ),
                  );
                }),
        ],
      ),
    );
  }
}
