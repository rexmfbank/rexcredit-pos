import 'package:flutter/material.dart';

class SaveDateListItem extends StatelessWidget {
  final dynamic paymentDateData;

  const SaveDateListItem({
    super.key,
    required this.paymentDateData,
  });

  @override
  Widget build(BuildContext context) {
    Color _getBackgroundColorByStatus() {
      if (paymentDateData.status!) {
        return const Color(0xffE9F6EF);
      } else {
        return const Color(0xffEBEFF8);
      }
    }

    Color _getTextColorByStatus() {
      if (paymentDateData.status!) {
        return const Color(0xff00B157);
      } else {
        return const Color(0xff14142A);
      }
    }

    final nextSavingsDueDate = paymentDateData.dueDate!;
    final nextSavingsDateInWord = nextSavingsDueDate.split(" ");

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: _getBackgroundColorByStatus(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: paymentDateData.status!
                ? Image.asset(
                    'assets/png/correct_icon.png',
                    height: 16,
                    width: 16,
                  )
                : const SizedBox(height: 16, width: 16),
          ),
          const SizedBox(height: 2.0),
          Text(
            nextSavingsDateInWord[0],
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: _getTextColorByStatus(),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            nextSavingsDateInWord[1],
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: _getTextColorByStatus(),
            ),
          ),
        ],
      ),
    );
  }
}
