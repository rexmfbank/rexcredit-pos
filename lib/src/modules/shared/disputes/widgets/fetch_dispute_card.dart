import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class FetchDisputeCard extends StatelessWidget {
  const FetchDisputeCard({
    super.key,
    required this.status,
    required this.transactionId,
    required this.message,
    required this.date,
  });

  final String status;
  final String transactionId;
  final String message;
  final String date;

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
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transaction ID: $transactionId',
                style: _style1,
              ),
            ),
            const SizedBox(height: 12.0),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Message: $message',
                  overflow: TextOverflow.ellipsis,
                  style: _style1,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status: $status', style: _style2),
                Text('Date: $date', style: _style2),
              ],
            )
          ],
        ),
      ),
    );
  }
}

const _style1 = TextStyle(
  fontWeight: FontWeight.w400,
);

const _style2 = TextStyle(color: AppColors.grey);
