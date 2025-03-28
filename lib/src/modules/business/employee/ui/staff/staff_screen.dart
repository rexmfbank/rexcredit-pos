import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/empty_staff_screen.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/non_empty_staff_screen.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeNotifier.notifier).getAllEmployees(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (ref.watch(employeeNotifier).employeeList.isEmpty) {
          return const EmptyStaffScreen();
        }

        return const NonEmptyStaffScreen();
      },
    );
  }
}
