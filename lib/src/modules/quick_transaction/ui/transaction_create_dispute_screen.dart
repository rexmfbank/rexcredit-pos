import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/models/create_dispute_payload.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/pos_transactions_provider.dart';
import 'package:rex_app/src/modules/quick_transaction/provider/trans_dispute_notifier.dart';
import 'package:rex_app/src/modules/quick_transaction/pos_trans/pos_trans_detail_widgets.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/extension_on_snackbar.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class TransactionCreateDisputeScreen extends ConsumerStatefulWidget {
  const TransactionCreateDisputeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransactionCreateDisputeScreenState();
}

class _TransactionCreateDisputeScreenState
    extends ConsumerState<TransactionCreateDisputeScreen> {
  @override
  void initState() {
    super.initState();
    // The dispute notifier outlives this screen, so drop the previous visit's
    // reason and description instead of showing them again.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transDisputeProvider.notifier).clearFields();
    });
  }

  Future<void> _showDisputeReasonPicker(List<DisputeReasonItem> reasons) async {
    if (reasons.isEmpty) {
      context.showSnack(message: "No dispute reasons available");
      return;
    }

    final selected = await showModalBottomSheet<DisputeReasonItem>(
      context: context,
      backgroundColor: AppColors.rexWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.aw, 16.ah, 8.aw, 8.ah),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Select dispute reason',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.rexPurpleDark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: reasons.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final reason = reasons[index];
                      return ListTile(
                        title: Text(reason.label),
                        onTap: () => Navigator.of(context).pop(reason),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      ref.read(transDisputeProvider.notifier).selectDisputeReason(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detail = ref.watch(memoryPosTransProvider);
    final disputeProvider = ref.watch(transDisputeProvider);
    final reasonsAsync = ref.watch(disputeReasonsProvider);

    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.all(0),
      isLoading: disputeProvider.isLoading || reasonsAsync.isLoading,
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarSubScreen(title: "Report Transaction", centerTitle: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          PosTransactionDetailSummary(trans: detail),
          SizedBox(height: 16.ah),
          RexTextField(
            controller: disputeProvider.reasonController,
            outerTitle: 'Dispute reason',
            hintText: 'Select a reason',
            showOuterTile: true,
            textFieldIsRequired: true,
            readOnly: true,
            onTap: () {
              reasonsAsync.when(
                data: (reasons) => _showDisputeReasonPicker(reasons),
                loading: () {},
                error: (error, _) {
                  context.showSnack(message: error.toString());
                },
              );
            },
            suffixIcon: const Icon(Icons.keyboard_arrow_down),
          ),
          SizedBox(height: 16.ah),
          RexTextField(
            controller: disputeProvider.descriptionController,
            outerTitle: 'Description',
            hintText: 'Describe the issue',
            showOuterTile: true,
            textFieldIsRequired: true,
            maxLines: 4,
            minLines: 3,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: RexElevatedButton(
              onPressed: () {
                ref.read(transDisputeProvider.notifier).validateInput(context);
              },
              buttonTitle: 'Submit Report',
            ),
          ),
        ],
      ),
    );
  }
}
