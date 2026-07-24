import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class AppbarSubScreen extends StatelessWidget implements PreferredSizeWidget {
  const AppbarSubScreen({
    super.key,
    required this.title,
    this.onBackBtnPress,
    this.centerTitle = false,
    this.showBackButton = true,
  });

  final String title;
  final Function()? onBackBtnPress;
  final bool centerTitle;
  final bool showBackButton;

  @override
  Size get preferredSize => Size.fromHeight(105.ah);

  void _handleBack(BuildContext context) {
    if (onBackBtnPress != null) {
      onBackBtnPress!();
    } else {
      context.pop();
    }
  }

  Widget _backButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleBack(context),
      child: CircleAvatar(
        radius: 22,
        foregroundColor: AppColors.rexPurpleLight,
        backgroundColor: Colors.white,
        child: Image.asset(AssetPath.iconArrowLeft, width: 18, height: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (centerTitle) {
      return SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          child: SizedBox(
            height: 48.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexBlack,
                  ),
                ),
                if (showBackButton)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _backButton(context),
                  ),
              ],
            ),
          ),
        ),
      );
    }

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
            if (showBackButton)
              GestureDetector(
                onTap: () => _handleBack(context),
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
