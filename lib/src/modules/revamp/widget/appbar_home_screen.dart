import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AppbarHomeScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarHomeScreen({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56.ah);

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
              onPressed: () => context.go(Routes.login),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.rexPurpleDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
