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
    ref.read(selectedTransferTypeProvider.notifier).state = newValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ref.read(internalTransferNotifier).isSendToBeneficiary
        ? RexCustomSpinner(
          padding: EdgeInsets.zero,
          options: const [Strings.transferToRexMFB],
          title: Strings.selectTransferTypeTitle,
          onOptionChanged: handleTransferTypeChanged,
        )
        : Container();
  }
}
