import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class SavedCardTile extends ConsumerStatefulWidget {
  const SavedCardTile({
    super.key,
    required this.debitCardData,
  });

  final DebitCardData debitCardData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedCardTileState();
}

class _SavedCardTileState extends ConsumerState<SavedCardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.ah),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 15.aw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.debitCardData.maskedPan,
                  style: TextStyle(
                    fontSize: 16.asp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.ah),
                Text(
                  "Expires ${widget.debitCardData.expiryDate}",
                  style: TextStyle(fontSize: 14.asp),
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
              ref.read(dashboardTopUpProvider.notifier).addDebitCard(
                    widget.debitCardData,
                  );
            },
          ),
        ],
      ),
    );
  }
}
