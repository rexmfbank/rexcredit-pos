import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/utility_widget/appbar_step_animation.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RexAppBar({
    super.key,
    this.step,
    this.stepValue,
    this.totalStepValue,
    this.barHeight,
    required this.shouldHaveBackButton,
    required this.title,
    this.subtitle,
    this.hasActionButton = false,
    this.showProfileImage = true,
    this.onActionButtonPressed,
    this.onBackButtonPressed,
    this.action,
  });

  final String? step;
  final int? stepValue;
  final int? totalStepValue;
  final double? barHeight;
  final bool shouldHaveBackButton;
  final String title;
  final String? subtitle;
  final bool hasActionButton;
  final bool showProfileImage;
  final VoidCallback? onActionButtonPressed;
  final VoidCallback? onBackButtonPressed;
  final Widget? action;

  @override
  Size get preferredSize => Size.fromHeight(barHeight ?? 150.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(top: 15.ah),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                right: 8.aw,
                top: 20.ah,
                bottom: 10.ah,
                left: 16.aw,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shouldHaveBackButton
                      ? InkWell(
                        onTap: () => Navigator.pop(context),
                        child: SizedBox(
                          height: 44,
                          child: SvgPicture.asset(
                            AssetPath.backButton,
                            height: 15,
                            width: 15,
                          ),
                        ),
                      )
                      : Container(),
                  (step == null && stepValue == null)
                      ? _RexAppBarActions(showProfileImage: showProfileImage)
                      : ((step != null)
                          ? Text(
                            step ?? '',
                            style: AppTextStyles.body3Regular.copyWith(
                              color: AppColors.rexPurpleLight,
                            ),
                          )
                          : StepAnimation(
                            step: stepValue!,
                            total: totalStepValue!,
                          )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.aw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title.isNotEmpty) ...[
                          Text(
                            title,
                            style: AppTextStyles.h4.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.rexPurpleLight,
                            ),
                          ),
                          SizedBox(height: 8.ah),
                        ],
                        if (subtitle.isNotBlank) ...[
                          Text(
                            subtitle!,
                            style: AppTextStyles.body2Regular.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColors.rexTint400,
                            ),
                          ),
                          SizedBox(height: 8.ah),
                        ],
                      ],
                    ),
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
class _RexAppBarActions extends ConsumerWidget {
  final bool showProfileImage;

  const _RexAppBarActions({required this.showProfileImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      ]
    );
  }
}
