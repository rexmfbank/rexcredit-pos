import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/spend/bill_payment/bill_airtime/provider/airtime_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';
import 'package:rex_app/src/utils/date_utils/change_date_format.dart';

import '../../../../../shared/widgets/pagination/pagination.dart';

class AirtimeHistoryTab extends ConsumerStatefulWidget {
  const AirtimeHistoryTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AirtimeHistoryTab();
}

class _AirtimeHistoryTab extends ConsumerState<AirtimeHistoryTab> {
  @override
  void initState() {
    ref.read(airtimeProvider.notifier).initPagingController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(airtimeProvider);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 4),
              Expanded(
                child: InkWell(
                  onTap: () => showDatePickerModal(context),
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.cardBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(AssetPath.calendar),
                        Text(
                          StringAssets.pickDate,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.cardGrey,
                          ),
                        ),
                        const Icon(Icons.expand_more)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: InkWell(
                  onTap: () {
                    /// TODO -> Fetch Statement in email
                    context.showSnackBar(message: StringAssets.notYetAvailable);
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: AppColors.cardBlue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        StringAssets.getStatement,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.cardGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
          Flexible(
            child: RefreshIndicator(
              color: AppColors.rexPurpleLight,
              onRefresh: () => Future.sync(
                () => state.historyPagingController.refresh(),
              ),
              child: PagedListView.separated(
                physics: const BouncingScrollPhysics(),
                pagingController: state.historyPagingController,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 5.h);
                },
                builderDelegate: PagedChildBuilderDelegate<TransferData>(
                  itemBuilder: (context, item, index) {
                    return AirtimeHistoryItem(
                      miniStatementData: item,
                      onTap: () {
                        context.showSnackBar(
                            message: StringAssets.notYetAvailable);
                      },
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    return FirstPageIndicatorErrorBuilder(
                      errorMessage:
                          state.historyPagingController.error.toString(),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return const NoItemsFoundIndicatorBuilder(
                      message: StringAssets.noHistoryAvailable,
                    );
                  },
                  firstPageProgressIndicatorBuilder: (context) {
                    return const FirstPageProgressIndicatorBuilder();
                  },
                  newPageProgressIndicatorBuilder: (context) {
                    return const NewPageProgressIndicatorBuilder();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showDatePickerModal(BuildContext context) async {
    DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 1)),
      end: DateTime.now(),
    );

    var datePicked = await showDateRangePicker(
        context: context,
        initialDateRange: dateRange,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        currentDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.input);

    if (datePicked != null && mounted) {
      ref.read(airtimeProvider.notifier).onDatePicked(datePicked);
    }
  }
}

class AirtimeHistoryItem extends StatelessWidget {
  const AirtimeHistoryItem({
    super.key,
    required this.miniStatementData,
    required this.onTap,
  });

  final TransferData miniStatementData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.aw,
          right: 16.aw,
          top: 12.ah,
          bottom: 8.ah,
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.cardPink,
              child: SvgPicture.asset(AssetPath.arrowLeftDown),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  miniStatementData.beneficiaryName ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.rexPurpleDark,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  miniStatementData.beneficiaryAccountNumber ?? 'N/A',
                  style: TextStyle(
                    color: AppColors.rexTint500,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  addNairaCurrencySymbol(
                      miniStatementData.amount?.toString() ?? '0.00'),
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  convertDateTimeTodMMMMyyyyFormat(
                          miniStatementData.transactionDate) ??
                      'N/A',
                  style: TextStyle(
                    color: AppColors.rexTint500,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
