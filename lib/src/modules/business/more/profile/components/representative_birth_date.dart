import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/modules/business/more/profile/providers/business_representative_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RepresentativeBirthDate extends ConsumerWidget {
  const RepresentativeBirthDate({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(businessRepresentativeScreenProvider);
    //
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: provider.dateOfBirth != null
            ? null
            : () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1920),
                  lastDate:
                      DateTime.now().subtract(const Duration(days: 18 * 365)),
                ).then((value) {
                  ref
                      .read(businessRepresentativeScreenProvider.notifier)
                      .onDateSelectionChange(value);
                });
              },
        child: RexTextField(
          outerTitle: StringAssets.dobText,
          obscureText: false,
          hintText: provider.dateOfBirth != null
              ? DateFormat.yMMMd().format(provider.dateOfBirth!)
              : '',
          controller: provider.dobController,
          showOuterTile: true,
          enabled: false,
        ),
      ),
    );
  }
}
