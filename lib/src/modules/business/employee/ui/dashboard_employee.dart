import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/dashboard_employee_appbar.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/staff_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardEmployeeScreen extends ConsumerStatefulWidget {
  const DashboardEmployeeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardEmployeeScreenState();
}

class _DashboardEmployeeScreenState extends ConsumerState<DashboardEmployeeScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeNotifier.notifier).setUpTabController(
            length: 2,
            vsync: this,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: true,
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackgroundGrey,
      isLoading: ref.watch(employeeNotifier).isLoading,
      appBar: const CustomAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.employeesText,
        subtitle: StringAssets.employeesAppbarSubtitle,
      ),
      body: const StaffScreen(),
    );

    // return Scaffold(
    //   appBar: const DashboardEmployeeAppBar(),
    //   body: DefaultTabController(
    //     length: ref.watch(employeeNotifier).employeeTabs.length,
    //     child: Column(
    //       children: [
    //         SaveTabBar(tabController: ref.watch(employeeNotifier).employeeTabController, tabs: ref.watch(employeeNotifier).employeeTabs),
    //         const SizedBox(height: 16),
    //         Flexible(
    //           child: TabBarView(
    //             controller: ref.watch(employeeNotifier).employeeTabController, // Set the TabController
    //             children: const [
    //               StaffScreen(),
    //               PayrollScreen(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
