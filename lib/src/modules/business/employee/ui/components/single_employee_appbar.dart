import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class SingleEmployeeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SingleEmployeeAppBar(
      {super.key,
      required this.shouldHaveBackButton,
      this.onBackButtonPressed});

  final bool shouldHaveBackButton;
  final VoidCallback? onBackButtonPressed;

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 8.0,
          right: 8.0,
          bottom: 4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            shouldHaveBackButton
                ? BackButton(
                    color: AppColors.rexPurpleDark,
                    onPressed: onBackButtonPressed,
                  )
                : Container(),
            _RexAppBarActions(),
          ],
        ),
      ),
    );
  }
}

///
class _RexAppBarActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          color: AppColors.rexPurpleDark,
          onPressed: () {},
          icon: Image.asset(AssetPath.notificationIconImage),
        ),
        IconButton(
          color: AppColors.rexPurpleDark,
          onPressed: () {},
          icon: Image.asset(AssetPath.userProfileIconImage),
        ),
      ],
    );
  }
}
