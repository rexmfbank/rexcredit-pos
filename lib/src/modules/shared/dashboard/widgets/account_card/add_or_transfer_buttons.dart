import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class AddOrTransferButtons extends StatelessWidget {
  const AddOrTransferButtons({
    super.key,
    required this.onClickAddMoney,
    required this.onClickTransferMoney,
  });

  final void Function()? onClickAddMoney;
  final void Function()? onClickTransferMoney;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexBackground,
                foregroundColor: AppColors.rexPurpleLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: onClickTransferMoney,
              child: const Text('Transfer'),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                fixedSize: const Size(150, 55),
                backgroundColor: AppColors.rexPurpleLight,
                foregroundColor: AppColors.rexWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onPressed: onClickAddMoney,
              child: const Text('Add money'),
            ),
          ),
        ],
      ),
    );
  }
}
