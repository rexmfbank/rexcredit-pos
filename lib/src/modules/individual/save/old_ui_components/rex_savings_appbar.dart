import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class RexSavingsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RexSavingsAppBar(
      {super.key,
      required this.title,
      required this.subtitle,
      this.hasActionButton = false,
      this.onActionButtonPressed});

  final String title;
  final String subtitle;
  final bool hasActionButton;
  final VoidCallback? onActionButtonPressed;

  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.rexPurpleDark,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.rexTint500,
                              fontSize: 12,
                              fontFamily: 'assets/fonts/Inter-Medium.ttf',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                 _RexAppBarActions(),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 2.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.rexPurpleDark,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.rexTint500,
                              fontSize: 12,
                              fontFamily: 'assets/fonts/Inter-Medium.ttf',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  hasActionButton
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: (onActionButtonPressed),
                            icon: Image.asset(AssetPath.plusButtonIcon),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
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
