import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/shared/bank_statement/providers/request_statement_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestEndDate extends ConsumerWidget {
  const RequestEndDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(requestStatementProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015),
            lastDate: DateTime(2080),
          ).then((value) {
            ref.read(requestStatementProvider.notifier).onEndDateChange(value);
          });
        },
        child: RexTextField(
          outerTitle: Strings.reqStatement2,
          obscureText: false,
          hintText:
              provider.endDate == null
                  ? ''
                  : DateFormat.yMMMd().format(provider.endDate!),
          controller: provider.endDateController,
          showOuterTile: true,
          enabled: false,
          textFieldIsRequired: true,
        ),
      ),
    );
  }
}
