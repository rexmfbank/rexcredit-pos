import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';

class FundSavingCardTitle extends ConsumerStatefulWidget {
  const FundSavingCardTitle({
    super.key,
    required this.debitCardData,
  });

  final DebitCardData debitCardData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FundSavingCardTitleState();
}

class _FundSavingCardTitleState extends ConsumerState<FundSavingCardTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image.asset(
          //   '',
          //   width: 50,
          //   height: 50,
          // ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.debitCardData.maskedPan,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Expires ${widget.debitCardData.expiryDate}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Checkbox(
            value: widget.debitCardData.isSelected,
            onChanged: (value) {
              setState(() {
                widget.debitCardData.isSelected =
                    !widget.debitCardData.isSelected;
              });
              ref
                  .read(targetSavingProvider.notifier)
                  .addDebitCard(widget.debitCardData);
            },
          ),
        ],
      ),
    );
  }
}
