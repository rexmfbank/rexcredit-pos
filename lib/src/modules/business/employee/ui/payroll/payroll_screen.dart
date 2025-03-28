import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/empty_payroll_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/payroll/non_empty_payroll_screen.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});
  final isPayrollEmpty = false;

  @override
  Widget build(BuildContext context) {
    if (isPayrollEmpty) {
      return const EmptyPayrollScreen();
    } else {
      return NonEmptyPayrollScreen();
    }
  }
}
