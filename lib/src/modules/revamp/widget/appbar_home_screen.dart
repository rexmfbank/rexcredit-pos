import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
