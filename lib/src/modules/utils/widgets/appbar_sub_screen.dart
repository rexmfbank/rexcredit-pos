import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class AppbarSubScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarSubScreen({super.key, required this.title, this.onBackBtnPress});

  final String title;
  final Function()? onBackBtnPress;

  @override
  Size get preferredSize => Size.fromHeight(105.ah);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 0.0,
          right: 24.0,
          bottom: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (onBackBtnPress != null) {
                  onBackBtnPress!();
                } else {
                  context.pop();
                }
              },
              child: Transform.translate(
                offset: Offset(-10, 0),
                child: CircleAvatar(
                  radius: 40,
                  foregroundColor: AppColors.rexPurpleLight,
                  backgroundColor: Colors.white,
                  child: Image.asset(AssetPath.iconArrowLeft),
                ),
              ),
            ),
            //SizedBox(width: 20.ah),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.rexPurpleDark3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
