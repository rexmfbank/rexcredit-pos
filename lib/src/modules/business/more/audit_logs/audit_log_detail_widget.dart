import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_item_text_title.dart';

class AuditLogDetailCard extends StatelessWidget {
  final String activity;
  final String ipAddress;
  final String dateTime;

  const AuditLogDetailCard({
    Key? key,
    this.activity = '',
    this.ipAddress = '',
    this.dateTime = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 24.0,
          right: 8.0,
          left: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlanSummaryItemTitleText(title: 'Activity'),
                PlanSummaryItemText(value: activity),
              ],
            ),
            const PlanSummaryDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlanSummaryItemTitleText(title: 'IP Address'),
                PlanSummaryItemText(value: ipAddress),
              ],
            ),
            const PlanSummaryDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PlanSummaryItemTitleText(title: 'Date'),
                PlanSummaryItemText(value: dateTime),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
