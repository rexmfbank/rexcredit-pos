import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/get_next_of_kin_future_provider.dart';
import 'package:rex_app/src/modules/individual/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/shared/providers/get_security_question_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_custom_text_field.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/rex_disabled_dropdown.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class NextOfKinDropdown extends ConsumerStatefulWidget {
  const NextOfKinDropdown({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NextOfKinDropdown();
}

class _NextOfKinDropdown extends ConsumerState<NextOfKinDropdown> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(nextOfKinRelationshipListProvider.notifier)
          .getNextOfKinRelationshipList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final nextOfKinList = ref.watch(nextOfKinRelationshipListProvider);
    final nextOfKinData = ref.watch(getNextOfKinFutureProvider);
    //
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
            top: 8.0,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringAssets.kinRelationship,
              style: TextStyle(
                color: AppColors.rexPurpleDark,
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
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
            child: nextOfKinList.when(
              data: (data) {
                return DropdownButtonFormField(
                  items: data
                      .map<DropdownMenuItem<FetchLookupDataByCodeResponseData>>(
                          (nextOfKinRelationship) {
                    return DropdownMenuItem(
                      value: nextOfKinRelationship,
                      child: Text(
                        nextOfKinRelationship.name,
                      ),
                    );
                  }).toList(),
                  onChanged: (FetchLookupDataByCodeResponseData? value) {
                    ref
                        .read(nextOfKinRelationshipProvider.notifier)
                        .onDropdownChange(value);
                  },
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
            ),
          ),
        ),
      ],
    );
  }
}
