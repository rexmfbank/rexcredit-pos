import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/borrow/providers/loan_repayment_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_number.dart';

class LoanRepaymentSchedule extends ConsumerWidget {
  const LoanRepaymentSchedule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanDetail = ref.watch(fetchLoanDetailProvider);
    return loanDetail.when(
      data: (data) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Repayment Schedule',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                    color: AppColors.rexPurpleDark,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 110.ah,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: data?.repaymentSchedule?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: LoanScheduleCard(
                        schedule: data?.repaymentSchedule?[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) => Container(),
      loading: () => Container(),
    );
  }
}

class LoanScheduleCard extends StatelessWidget {
  const LoanScheduleCard({
    super.key,
    required this.schedule,
  });

  final RepaymentSchedule? schedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: schedule?.status == 'Completed'
            ? const Color.fromRGBO(165, 214, 167, 1)
            : const Color(0xffEBEFF8),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Due Date'),
          Flexible(
            child: Text(schedule?.dueDate?.dateReadable() ?? 'n/a'),
          ),
          SizedBox(height: 4.ah),
          const Text('Oustanding'),
          Flexible(
            child:
                Text(schedule?.outstandingAmount?.formatCurrencyNum() ?? 'n/a'),
          ),
        ],
      ),
    );
  }
}
