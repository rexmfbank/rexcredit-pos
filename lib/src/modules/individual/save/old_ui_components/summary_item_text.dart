import 'package:flutter/material.dart';

class PlanSummaryItemText extends StatelessWidget {
  const PlanSummaryItemText({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 8.0, left: 24.0, right: 24.0, bottom: 12.0),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
