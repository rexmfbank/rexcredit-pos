import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class CountryTileDisabled extends StatelessWidget {
  const CountryTileDisabled({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CheckboxListTile(
        value: false,
        onChanged: (value) {},
        contentPadding: const EdgeInsets.all(10.0),
        title: const Text(
          'Country',
          style: TextStyle(
            color: AppColors.rexPurpleDark2,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        tileColor: AppColors.rexWhite,
        secondary: const Icon(Icons.flag),
      ),
    );
  }
}
