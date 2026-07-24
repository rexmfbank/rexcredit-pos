import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class LoginHomeAppbar extends ConsumerWidget {
  const LoginHomeAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = AppKeysStorage.getConfig();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hello ${config.loginFirstname}',
          style: TextStyle(
            color: AppColors.rexPurpleLight,
            fontWeight: FontWeight.w700,
            fontSize: 14.asp,
          ),
        ),
        Row(
          children: [
            Image.asset(AssetPath.iconBell),
            SizedBox(width: 4),
            CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.rexPurpleLight,
              child: Text('U'),
            ),
          ],
        ),
      ],
    );
  }
}
