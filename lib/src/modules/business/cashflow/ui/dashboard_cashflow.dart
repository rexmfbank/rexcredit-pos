import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/dashboard_cashflow_actions.dart';
import 'package:rex_app/src/modules/business/cashflow/ui/components/dashboard_cashflow_transactions.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/providers/dashboard_providers.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/rex_savings_balance_card.dart';
import 'package:rex_app/src/modules/shared/widgets/page_view_text_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/currency.dart';

class DashboardCashflowScreen extends StatefulHookConsumerWidget {
  const DashboardCashflowScreen({super.key});

  _DashboardCashflowScreenState createState() =>
      _DashboardCashflowScreenState();
}

class _DashboardCashflowScreenState
    extends ConsumerState<DashboardCashflowScreen> {
  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final pageIndex = ref.watch(dashboardHomePageViewIndexProvider);
    // Replace this with your data source or Riverpod state
    final List<double> chartData = [10, 80, 35, 25, 45, 30, 45, 48];

    return Scaffold(
      appBar: const RexAppBar(
        step: null,
        shouldHaveBackButton: false,
        title: 'Cashflow',
        subtitle: StringAssets.employeesAppbarSubtitle,
        hasActionButton: false,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          RexSavingsBalanceCard(
            cardTitle: 'Total Revenue',
            iconPath: 'assets/png/account_balance_icon.png',
            total: addNairaCurrencySymbol('1,453,962'),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(18.0),
          //   ),
          //   margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          //   child: Image.asset(
          //     'assets/png/chart_image.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.all(9),
            margin: EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            height: 300,
            child: LineChartWidget(chartData: chartData),
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
            padding: const EdgeInsets.all(6.0),
            decoration: const BoxDecoration(
              color: AppColors.lightGrey2,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageViewTextButton(
                    textOnButton: StringAssets.quickActionsText,
                    pageController: pageController,
                    backgroundColor: pageIndex == 0 ? AppColors.rexWhite : null,
                    shape: pageIndex == 0 ? roundRectBorder : null,
                    onPressed: () {
                      pageController.previousPage(
                        duration: duration300ms,
                        curve: easeInCurve,
                      );
                    },
                  ),
                ),
                Expanded(
                  child: PageViewTextButton(
                    textOnButton: StringAssets.transactionsText,
                    pageController: pageController,
                    backgroundColor: pageIndex == 1 ? AppColors.rexWhite : null,
                    shape: pageIndex == 1 ? roundRectBorder : null,
                    onPressed: () {
                      pageController.nextPage(
                        duration: duration300ms,
                        curve: easeInCurve,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            height: 450,
            child: PageView(
              controller: pageController,
              onPageChanged: (int value) {
                ref.read(dashboardHomePageViewIndexProvider.notifier).state =
                    value;
              },
              children: const [
                DashboardCashflowActions(),
                DashboardCashflowTransactions(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  LineChartWidget({
    super.key,
    required this.chartData,
  });

  final List<double> chartData;
  final List<Color> gradientColors = [
    Colors.blue,
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 25,),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 10,
                getTitlesWidget: (value, _) {
                  String text = '';
                  // Replace this with your custom x-axis labels
                  switch (value.toInt()) {
                    case 1:
                      text = 'Feb';
                      break;
                    case 2:
                      text = 'Mar';
                      break;
                    case 3:
                      text = 'Apr';
                      break;
                    case 4:
                      text = 'May';
                      break;
                    case 5:
                      text = 'Jun';
                      break;
                    case 6:
                      text = 'Jul';
                      break;
                    case 7:
                      text = 'Aug';
                      break;
                    default:
                      text = '';
                      break;
                  }
                  return Text(text);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),
          minX: 0,
          maxX: chartData.length.toDouble() - 1,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
                spots: chartData.asMap().entries.map((entry) {
                  return FlSpot(entry.key.toDouble(), entry.value);
                }).toList(),
                isCurved: true,
                gradient: LinearGradient(colors: [Colors.blue]),
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
