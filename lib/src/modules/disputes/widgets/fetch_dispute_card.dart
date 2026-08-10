import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/api/models/fetch_dispute_payload.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_number.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class FetchDisputeCard extends StatelessWidget {
  const FetchDisputeCard({super.key, required this.dispute});

  final FetchDisputeData dispute;

  String get _reason =>
      (dispute.disputeReason ?? '').replaceAll('_', ' ').toLowerCase();

  String get _date {
    final date = dispute.createdAtDate;
    if (date == null) return dispute.createdAt ?? '';
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 12.0,
          bottom: 12.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'RRN: ${dispute.rrn ?? '-'}',
                    overflow: TextOverflow.ellipsis,
                    style: _style1,
                  ),
                ),
                Text(
                  '\u20A6${dispute.amount.toCommaSeparatedWithDecimals()}',
                  style: _style1,
                ),
              ],
            ),
            // const SizedBox(height: 8.0),
            // Text('RRN: ${dispute.rrn ?? '-'}', style: _style2),
            const SizedBox(height: 8.0),
            Text(
              'Reason: $_reason',
              overflow: TextOverflow.ellipsis,
              style: _style1,
            ),
            const SizedBox(height: 8.0),
            Flexible(
              child: Text(
                "Description: ${dispute.description ?? ''}",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: _style1,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Status: ${dispute.status ?? '-'}', style: _style2),
            const SizedBox(height: 8.0),
            Text(
              "Date & Time: $_date",
              overflow: TextOverflow.ellipsis,
              style: _style2,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('Status: ${dispute.status ?? '-'}', style: _style2),
            //     Flexible(
            //       child: Text(
            //         _date,
            //         overflow: TextOverflow.ellipsis,
            //         style: _style2,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

const _style1 = TextStyle(fontWeight: FontWeight.w400);

const _style2 = TextStyle(color: AppColors.grey);
