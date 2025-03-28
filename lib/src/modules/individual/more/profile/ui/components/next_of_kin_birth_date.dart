import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/get_next_of_kin_future_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/next_of_kin_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class NextOfKinBirthDate extends ConsumerWidget {
  const NextOfKinBirthDate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(nextOfKinNotifier);
    //
    return Align(
        alignment: Alignment.centerLeft,
        child: ref.watch(getNextOfKinFutureProvider).maybeWhen(
              data: (data) {
                if(data == GetNextOfKinData.empty()){
                  return GestureDetector(
                    onTap: ()=> showDatePicker(
                      context: context,
                      initialDate: DateTime(2000),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2005),
                    ).then((value) {
                      ref
                          .read(nextOfKinNotifier.notifier)
                          .onDateSelectionChange(value);
                    }),
                    child: RexTextField(
                      outerTitle: StringAssets.dobText,
                      obscureText: false,
                      hintText: provider.dateOfBirth == null
                          ? 'Select Date'
                          : DateFormat.yMMMd().format(provider.dateOfBirth!),
                      controller: null,
                      showOuterTile: true,
                      enabled: false,
                      readOnly: true,
                    ),
                  );
                }
                return RexTextField(
                  outerTitle: StringAssets.dobText,
                  showOuterTile: true,
                  obscureText: false,
                  hintText: data.dob,
                  readOnly: data.dob.isNotBlank,
                  inputType: TextInputType.phone,
                );
              },
              orElse: () => RexTextField(
                outerTitle: StringAssets.dobText,
                obscureText: false,
                hintText: provider.dateOfBirth == null
                    ? 'Select Date'
                    : DateFormat.yMMMd().format(provider.dateOfBirth!),
                controller: null,
                showOuterTile: true,
                enabled: false,
                readOnly: true,
                onTap:  () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2005),
                  ).then((value) {
                    ref
                        .read(nextOfKinNotifier.notifier)
                        .onDateSelectionChange(value);
                  });
                },
              ),
            ));
  }
}
