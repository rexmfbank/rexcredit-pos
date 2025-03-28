import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class SavePayDatePicker extends HookConsumerWidget {
  const SavePayDatePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateController = useTextEditingController();
    DateTime? date = DateTime.now();
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1950),
            lastDate: DateTime(2003),
          ).then((value) {
            date = value;
          });
        },
        child: RexTextField(
          outerTitle: 'Next payment date',
          obscureText: false,
          hintText: DateFormat.yMMMd().format(date),
          controller: dateController,
          enabled: false,
        ),
      ),
    );
  }
}
