import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';

class LoginHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LoginHomeAppbar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(125.ah);

  @override
  Widget build(BuildContext context) {
    final config = AppKeysStorage.getConfig();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 8,
          top: 16.0,
        ),
        child: Row(
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
        ),
      ),
    );
  }
}
