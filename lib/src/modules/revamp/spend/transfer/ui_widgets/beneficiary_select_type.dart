import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_spinner.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BeneficiarySelectType extends ConsumerStatefulWidget {
  const BeneficiarySelectType({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BeneficiarySelectTypeState();
}

class _BeneficiarySelectTypeState extends ConsumerState<BeneficiarySelectType> {
  void handleTransferTypeChanged(String? newValue) {
    // selectedTransferType.value = newValue ?? "";
    debugPrint("AccountType: $newValue");
    ref.read(selectedTransferTypeProvider.notifier).state = newValue ?? "";
    debugPrint(
        "SelectedTransferType: ${ref.read(selectedTransferTypeProvider)}");
  }

  @override
  Widget build(BuildContext context) {
    return ref.read(internalTransferNotifier).isSendToBeneficiary
        ? RexCustomSpinner(
            padding: EdgeInsets.zero,
            options: const [
              StringAssets.transferToRexMFB,
            ],
            title: StringAssets.selectTransferTypeTitle,
            onOptionChanged: handleTransferTypeChanged,
          )
        : Container();
  }
}
