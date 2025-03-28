import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';

class LoanDueDateItem extends StatelessWidget {
  final RepaymentSchedule? repaymentDateData;

  const LoanDueDateItem({
    super.key,
    required this.repaymentDateData,
  });

  @override
  Widget build(BuildContext context) {
    Color _getBackgroundColorByStatus() {
      if (repaymentDateData?.status == "Completed") {
        return const Color(0xffE9F6EF);
      } else {
        return const Color(0xffEBEFF8);
      }
    }

    Color _getTextColorByStatus() {
      if (repaymentDateData?.status == "Completed") {
        return const Color(0xff00B157);
      } else {
        return const Color(0xff14142A);
      }
    }

    String _getDaySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String formatDateString(String dateString) {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      final day = date.day;
      final suffix = _getDaySuffix(day);
      return '${months[date.month - 1]} $day$suffix';
    }

    final nextSavingsDueDate = repaymentDateData?.dueDate.toString();
    final nextSavingsDateInWord = nextSavingsDueDate?.split("-");

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
            child: repaymentDateData?.status == "Completed"
                ? Image.asset(
                    'assets/png/correct_icon.png',
                    height: 16,
                    width: 16,
                  )
                : const SizedBox(height: 16, width: 16),
          ),
          const SizedBox(height: 2.0),
          Text(
            nextSavingsDueDate != null
                ? formatDateString(nextSavingsDueDate).split(" ").first
                : '',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: _getTextColorByStatus(),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            nextSavingsDueDate != null
                ? formatDateString(nextSavingsDueDate).split(" ").last
                : '',
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
