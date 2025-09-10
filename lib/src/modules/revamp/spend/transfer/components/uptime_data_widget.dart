import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class UptimeDataWidget extends StatelessWidget {
  const UptimeDataWidget({
    super.key,
    required this.bankName,
    required this.percent,
  });

  final String bankName;
  final num percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.ar),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bankName),
          Text(
            '$percent%',
            style: TextStyle(
              color: percent > 90 ? AppColors.rexGreen : AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
