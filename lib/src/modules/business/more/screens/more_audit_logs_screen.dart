import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/screens/components/audit_log_item.dart';
import 'package:rex_app/src/modules/shared/spend/transfer/components/transfer_beneficiary_searchbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class AuditLogsScreen extends HookConsumerWidget {
  const AuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isLogsEmpty = false;
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: 'Audit Log',
        subtitle: 'Show all logs of all internal user activities',
        hasActionButton: false,
      ),
      body: isLogsEmpty
          ? Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 300,
                    child: Lottie.asset('assets/lottiefiles/empty_logs.json'),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        'No Audit Log Yet!',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.rexPurpleLight,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 56.0, right: 56.0),
                      child: Text(
                        'This will show you logs of all internal user activities across the business',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: AppColors.rexTint500,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: TransferBeneficiarySearchBar(
                          hintText: 'Search by Name',
                        ),
                      ),
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/png/filter_icon.png',
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {
                    context.push(
                        '${RouteName.dashboardMoreBusiness}/${RouteName.auditLogDetail}');
                  },
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {
                    context.push(
                        '${RouteName.dashboardMoreBusiness}/${RouteName.auditLogDetail}');
                  },
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {},
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {},
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {},
                ),
                AuditLogItemCard(
                  name: 'Joseph Yobo',
                  email: 'jyobo@example.com',
                  dateTime: 'Feb 22, 2023 at 05:14pm',
                  onTap: () {},
                ),
              ],
            ),
    );
  }
}
