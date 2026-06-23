import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/snack_bar_ext.dart';
import 'package:rex_app/src/utils/app_keys.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AppbarHomeScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHomeScreen({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56.ah);

  void _navigateOnCheck(String route, BuildContext context) {
    final config = AppKeysStorage.getConfig();
    //
    if (config.isAuthFailed == 'true') {
      context.showSnack(message: Strings.downloadSetting);
    } else if (config.isExchangeDone.isEmpty) {
      context.showSnack(message: Strings.downloadSetting);
    } else if (config.serialNumber.isEmpty) {
      context.showSnack(message: Strings.downloadSetting);
    }   else {
      context.push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
            ),
            OutlinedButton(
              onPressed: () => _navigateOnCheck(Routes.login, context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.rexPurpleDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 8.0, left: 24.0, right: 24.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Quick Actions',
  //             style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
