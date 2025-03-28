import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/borrow/components/agent_loan_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AgentLoanDashboard extends StatelessWidget {
  const AgentLoanDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: true,
        title: StringAssets.loan,
        subtitle: StringAssets.applyForLoansHere,
        hasActionButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const LoanDashboardCard(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: LoanActionCard(
                    iconPath: AssetPath.paper,
                    title: StringAssets.loanRecord,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: LoanActionCard(
                    iconPath: AssetPath.wallet,
                    title: StringAssets.loanRepayment,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringAssets.recommendedLoan,
                  style: TextStyle(
                    color: AppColors.rexBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push(
                        '${RouteName.dashboardBorrowBusiness}/${RouteName.agentLoanRecommended}');
                  },
                  child: Text(
                    StringAssets.viewAll,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: LoanProductsBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
