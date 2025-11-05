import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/bank_statement/providers/request_statement_provider.dart';
import 'package:rex_app/src/modules/shared/bank_statement/widgets/request_dropdown_format.dart';
import 'package:rex_app/src/modules/shared/bank_statement/widgets/request_end_date.dart';
import 'package:rex_app/src/modules/shared/bank_statement/widgets/request_start_date.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestBankStatementScreenBody extends ConsumerWidget {
  const RequestBankStatementScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const RequestStartDate(),
        const RequestEndDate(),
        const RequestDropdownFormat(),
        Padding(
          padding: EdgeInsets.only(left: 16.aw, right: 16.aw),
          child: RexElevatedButton(
            onPressed: () {
              ref
                  .read(requestStatementProvider.notifier)
                  .validateAndSubmit(context);
            },
            buttonTitle: Strings.reqStatement3,
          ),
        ),
      ],
    );
  }
}
