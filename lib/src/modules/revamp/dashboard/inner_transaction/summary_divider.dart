import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class PlanSummaryDivider extends StatelessWidget {
  const PlanSummaryDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.ah),
      child: Divider(
        thickness: 0.5,
        color: Colors.grey[350],
      ),
    );
  }
}
