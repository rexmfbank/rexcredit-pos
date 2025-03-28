import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/employee/core/employee/employee_notifier.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/add_employee_widget.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_card_item.dart';
import 'package:rex_app/src/modules/business/employee/ui/components/show_staff_actions_modal.dart';
import 'package:rex_app/src/modules/business/employee/ui/staff/widgets/employee_searchbar.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/rex_savings_balance_card.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class NonEmptyStaffScreen extends ConsumerWidget {
  const NonEmptyStaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        RexSavingsBalanceCard(
          cardTitle: StringAssets.totalNumberOfEmployees,
          total: ref.watch(employeeNotifier).employeeList.length.toString(),
          iconPath: AssetPath.totalEmployeeIcon,
          onIconTap: () => ref
              .watch(employeeNotifier.notifier)
              .getAllEmployees(context: context),
        ),
        const AddNewEmployeeCard(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: EmployeeSearchBar(),
              ),
              SizedBox(width: 4.aw),
              Padding(
                padding: EdgeInsets.only(bottom: 5.ah),
                child: Image.asset(
                  AssetPath.filterIcon,
                  height: 40.ah,
                  width: 40.aw,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollState) {
              if (scrollState is ScrollEndNotification) {}
              return true;
            },
            child: RefreshIndicator(
              onRefresh: () =>
                  ref.watch(employeeNotifier.notifier).refreshCall(context),
              child: Scrollbar(
                thickness: 5.aw,
                child: ListView.builder(
                  controller: ref.watch(employeeNotifier).scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      ref.watch(employeeNotifier).filteredEmployeeList.length,
                  itemBuilder: (context, index) => EmployeeCardItem(
                    iconPath: ref
                            .watch(employeeNotifier)
                            .filteredEmployeeList
                            .elementAt(index)
                            .photoLink
                            .isNotBlank
                        ? ref
                            .watch(employeeNotifier)
                            .filteredEmployeeList
                            .elementAt(index)
                            .photoLink!
                        : AssetPath.sampleProfileImage,
                    employeeName:
                        '${ref.watch(employeeNotifier).filteredEmployeeList.elementAt(index).firstname} ${ref.watch(employeeNotifier).filteredEmployeeList.elementAt(index).lastname}',
                    employeeDesignation: ref
                            .watch(employeeNotifier)
                            .filteredEmployeeList
                            .elementAt(index)
                            .designation ??
                        '',
                    onTap: () {
                      showEmployeeActionsModal(
                        context: context,
                        employeeInfo: ref
                            .watch(employeeNotifier)
                            .filteredEmployeeList
                            .elementAt(index),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.ah),
      ],
    );
  }
}
