import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class UtilityBillElectricity extends HookConsumerWidget {
  const UtilityBillElectricity({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meterNumberController = useTextEditingController();
    //
    final authToken = ref.watch(userAuthTokenProvider) ?? 'null';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 4.0),
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
            top: 8.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Electricity provider',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.0),
            ),
            /* child: utilityApiResponse.when(
              data: (theApiResponse) {
                return DropdownButtonFormField(
                  items: theApiResponse.data
                      .map<DropdownMenuItem<UtilityType>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                  onChanged: (UtilityType? value) {},
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: rexInputBorder,
                    enabledBorder: rexInputBorder,
                    focusedBorder: rexInputBorder,
                  ),
                  isExpanded: true,
                );
              },
              error: (obj, stack) => const RexDisabledDropdown(),
              loading: () => const RexDisabledDropdown(),
            ),*/
          ),
        ),
        RexTextField(
          outerTitle: 'Meter number',
          hintText: '',
          controller: meterNumberController,
          obscureText: false,
        ),
      ],
    );
  }
}
