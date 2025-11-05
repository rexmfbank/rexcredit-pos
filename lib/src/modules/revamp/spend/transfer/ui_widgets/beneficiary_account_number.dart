import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/spend/transfer/providers/internal_transfer_notifier.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BeneficiaryAccountNumber extends ConsumerWidget {
  const BeneficiaryAccountNumber({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Debouncer debouncer = Debouncer(milliseconds: 800);
    return RexTextField(
      horizontalPadding: 0,
      outerTitle: Strings.accountNumberTitle,
      showOuterTile: true,
      hintText: Strings.accountNumberHint,
      controller: ref.read(internalTransferNotifier).accountNumberController,
      inputType: const TextInputType.numberWithOptions(decimal: true),
      validator: (value) => TextfieldValidator.accountNo(value),
      inputFormatter: [
        RemoveFirstDigitOnPasteFormatter(),
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        if (value.isNotEmpty && value.length == 10) {
          FocusScope.of(context).unfocus();
          debouncer.run(() async {
            ref.read(internalTransferNotifier.notifier).accountNameLookUp();
          });
        } else {
          debouncer.cancel();
        }
        // ref
        //     .read(internalTransferNotifier.notifier)
        //     .updateBeneficiaryInfo(name: "", accountNo: "");
      },
      obscureText: false,
    );
  }
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

class AccountNumberTextField extends ConsumerWidget {
  const AccountNumberTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Debouncer debouncer = Debouncer(milliseconds: 800);
    return Column(
      children: [
        RexTextField(
          horizontalPadding: 0,
          outerTitle: Strings.accountNumberTitle,
          showOuterTile: true,
          hintText: Strings.accountNumberHint,
          controller:
              ref.read(internalTransferNotifier).accountNumberController,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) => TextfieldValidator.accountNo(value),
          inputFormatter: [
            RemoveFirstDigitOnPasteFormatter(),
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isNotEmpty && value.length == 10) {
              FocusScope.of(context).unfocus();
              debouncer.run(() async {
                ref.read(internalTransferNotifier.notifier).accountNameLookUp();
              });
            } else {
              debouncer.cancel();
            }
            // ref
            //     .read(internalTransferNotifier.notifier)
            //     .updateBeneficiaryInfo(name: "", accountNo: "");
          },
          obscureText: false,
        ),
        Text(
          "",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.asp,
            color: AppColors.rexPurpleDark,
          ),
        ),
      ],
    );
  }
}
