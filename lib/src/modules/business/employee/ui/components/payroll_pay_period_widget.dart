import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class PayPeriodWidget extends StatelessWidget {
  final String imagePath;
  final String datePeriod;
  final String month;
  final VoidCallback onPressed;

  const PayPeriodWidget({
    super.key, 
    required this.imagePath,
    required this.datePeriod,
    required this.month,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffE1F2EE),
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: const EdgeInsets.all(18.0),
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Yay! Pay period',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            datePeriod,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Please run payroll by Wednesday, June 28 to pay your employees for the month',
            style: TextStyle(
                fontSize: 15.0,
                color: AppColors.grey,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Text(
                'Prepare $month payroll',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
