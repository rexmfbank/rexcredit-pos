import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/support/providers/support_future_provider.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/providers/receipt_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/receipt_row.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_dotted_line.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/string_utils.dart';
import 'package:screenshot/screenshot.dart';

class TransferReceiptScreen extends ConsumerStatefulWidget {
  final TransferData receiptData;
  const TransferReceiptScreen({
    super.key,
    required this.receiptData,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransferReceiptScreenState();
}

class _TransferReceiptScreenState extends ConsumerState<TransferReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: AppBar(
        toolbarHeight: 30.ah,
        backgroundColor: AppColors.rexBackgroundGrey,
        leading: BackButton(
          color: AppColors.rexPurpleDark,
          onPressed: context.pop,
        ),
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 8.aw),
          //   child: InkWell(
          //     onTap: () async {
          //       final image = await ref
          //           .watch(receiptNotifier)
          //           .screenshotController
          //           .captureAsUiImage();
          //       if (image != null) {
          //         final saveImage = await image.toByteData();
          //         if (context.mounted) {
          //           await ref
          //               .watch(receiptNotifier.notifier)
          //               .downloadImage(
          //                   context: context,
          //                   transactionType: widget.receiptData.tranType ?? '',
          //                   imageBytes: saveImage!.buffer.asUint8List());
          //         }
          //         return;
          //       }
          //       if (context.mounted) {
          //         context.showToast(
          //           backgroundColor: AppColors.rexPurpleLight,
          //           message: StringAssets.failed,
          //         );
          //       }
          //     },
          //     child: Icon(
          //       Icons.downloading_sharp,
          //       size: 25.ar,
          //       color: AppColors.rexPurpleLight,
          //     ),
          //   ),
          // ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Screenshot(
        controller: ref.watch(receiptNotifier).screenshotController,
        child: RepaintBoundary(
          key: ref.watch(receiptNotifier).globalKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.aw, vertical: 20.aw),
            color: AppColors.rexBackgroundGrey,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      StringAssets.transactionReceipt,
                      style: AppTextStyles.h3.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.rexPurpleDark2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.aw),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(AssetPath.rexLogoImage),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 14.ah),
                RexDottedLine(
                  dashLength: 7,
                  color: AppColors.rexPurpleLight.withOpacity(0.6),
                ),
                SizedBox(height: 20.ah),
                if (widget.receiptData.senderName.isNotBlank) ...[
                  ReceiptRow(
                    title: StringAssets.senderName,
                    subtitle:
                        widget.receiptData.senderName.toTitleCase() ?? 'n/a',
                  ),
                ],
                ReceiptRow(
                  title: StringAssets.senderAccount,
                  subtitle: widget.receiptData.senderAccountNumber ?? 'n/a',
                ),
                const ReceiptRow(
                  title: StringAssets.senderBank,
                  subtitle: StringAssets.rexMFB,
                ),
                ReceiptRow(
                  title: StringAssets.transactionDate,
                  subtitle: DateFormat('yyyy/MM/dd').format(
                    widget.receiptData.transactionDate ?? DateTime.now(),
                  ),
                ),
                ReceiptRow(
                  title: StringAssets.beneficiary,
                  subtitle:
                      widget.receiptData.beneficiaryName.toTitleCase() ?? '-',
                ),
                ReceiptRow(
                  title: StringAssets.beneficiaryAccount,
                  subtitle: widget.receiptData.beneficiaryAccountNumber ?? '-',
                ),
                ReceiptRow(
                  title: StringAssets.beneficiaryDestination,
                  subtitle: widget.receiptData.billerName ?? '-',
                ),
                ReceiptRow(
                  title: StringAssets.transactionAmount,
                  subtitle:
                      (widget.receiptData.amount ?? 0).formatCurrencyNum(),
                ),
                ReceiptRow(
                  title: StringAssets.narration,
                  subtitle: widget.receiptData.narration ?? '-',
                ),
                ReceiptRow(
                  title: StringAssets.refrenceNumber,
                  subtitle: widget.receiptData.tranUniqueRefNo ?? '-',
                ),
                ReceiptRow(
                  title: StringAssets.status,
                  subtitle: widget.receiptData.transactionStatus ?? '-',
                  showDivider: false,
                ),
                SizedBox(height: 30.ah),
                RexDottedLine(
                  dashLength: 7,
                  color: AppColors.rexPurpleLight.withOpacity(0.6),
                ),
                SizedBox(height: 20.ah),
                Text(
                  StringAssets.receiptDescription,
                  style: AppTextStyles.body3Regular.copyWith(
                    fontSize: 10.asp,
                    height: 1.5,
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: 8.ah),
                Text(
                  StringAssets.receiptCareContact(
                    ref.watch(supportFutureProvider(context)).value?.phoneNo ??
                        '+234-1-448-5252',
                    ref.watch(supportFutureProvider(context)).value?.email ??
                        'customer.care@rexafrica',
                  ),
                  style: AppTextStyles.body3Regular.copyWith(
                    fontSize: 10.asp,
                    height: 1.5,
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: 74.ah),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.aw),
            child: RexFlatButton(
              onPressed: () =>
                  ref.watch(receiptNotifier.notifier).shareImage(context),
              buttonTitle: StringAssets.share,
              backgroundColor: null,
            ),
          ),
          SizedBox(height: 10.ah),
        ],
      ),
    );
  }
}
