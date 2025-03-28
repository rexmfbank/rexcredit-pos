import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class CountryTile extends ConsumerWidget {
  const CountryTile({
    super.key,
    required this.onChanged,
    required this.value,
    required this.countryTitle,
    required this.countryUrl,
  });

  final void Function(bool?)? onChanged;
  final bool? value;
  final String countryTitle;
  final String countryUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(
          countryTitle,
          style: const TextStyle(
            color: AppColors.rexPurpleDark2,
            fontWeight: FontWeight.w500,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        tileColor: AppColors.rexWhite,
        secondary: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(35.ar),
          ),
          child: Image.network(
            countryUrl,
            height: 30.ah,
            width: 30.aw,
            errorBuilder: (context, obj, stack) => Icon(
              Icons.flag,
              size: 25.ar,
            ),
          ),
        ),
      ),
    );
  }
}
