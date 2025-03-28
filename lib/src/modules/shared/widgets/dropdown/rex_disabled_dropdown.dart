import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexDisabledDropdown extends StatelessWidget {
  const RexDisabledDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: null,
      onChanged: null,
      decoration: InputDecoration(
        focusColor: Colors.black,
        border: AppConstants.rexInputBorder,
        enabledBorder: AppConstants.rexInputBorder,
        focusedBorder: AppConstants.rexInputBorder,
      ),
      isExpanded: true,
    );
  }
}
