import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AppbarSubScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarSubScreen({super.key, required this.title, this.onTap});

  final String title;
  final Function()? onTap;

  @override
  Size get preferredSize => Size.fromHeight(56.ah);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                onTap ?? context.pop();
              },
              child: CircleAvatar(
                radius: 18,
                foregroundColor: AppColors.rexPurpleLight,
                backgroundColor: AppColors.rexLightBlue4,
                child: Icon(Icons.arrow_back),
              ),
            ),
            SizedBox(width: 24.ah),
            Text(
              title,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
