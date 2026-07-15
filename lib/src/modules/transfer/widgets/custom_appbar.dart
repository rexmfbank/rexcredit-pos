import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/linear_loading_indicator.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/extensions/extension_on_string.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.shouldHaveBackButton = true,
    this.showImage = true,
    this.showNotification = true,
    this.showAccountBalance = false,
    this.subtitle,
    this.onBackButtonPressed,
    this.suffixWidget,
    this.height,
    this.isloading = false,
  });

  final bool shouldHaveBackButton;
  final bool showImage;
  final bool showNotification;
  final bool showAccountBalance;
  final String title;
  final String? subtitle;
  final VoidCallback? onBackButtonPressed;
  final Widget? suffixWidget;
  final double? height;
  final bool isloading;

  @override
  Size get preferredSize => Size.fromHeight(height ?? 150.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearLoadingIndicator(loading: isloading),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.ah, horizontal: 20.aw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.aw),
                        child: Visibility(
                          visible: shouldHaveBackButton,
                          child: InkWell(
                            onTap: () {
                              if (onBackButtonPressed != null) {
                                onBackButtonPressed!();
                              } else {
                                // Default behavior if no custom action is provided
                                context.pop();
                              }
                            },
                            child: SizedBox(
                              height: 44,
                              child: SvgPicture.asset(
                                AssetPath.backButton,
                                height: 15,
                                width: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          if (showNotification) ...[
                            IconButton(
                              color: AppColors.rexPurpleDark,
                              onPressed:
                                  () => context.push(Routes.notificationPage),
                              icon: Image.asset(
                                AssetPath.notificationIconImage,
                              ),
                            ),
                            SizedBox(width: 7.aw),
                          ],
                          SizedBox(width: 7.aw),
                          if (showImage) ...[
                            InkWell(
                              onTap: () {
                                context.push(
                                  "${Routes.dashboardMore}/${Routes.profile}",
                                );
                              },
                              child: Icon(Icons.person),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2.ah),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (subtitle.isNotBlank) ...[
                              Text(
                                title,
                                style: AppTextStyles.h1.copyWith(
                                  color: AppColors.rexPurpleLight,
                                  fontSize: 20.asp,
                                ),
                              ),
                            ],
                            if (subtitle.isNotBlank) ...[
                              SizedBox(height: 2.ah),
                              SizedBox(
                                child: Text(
                                  subtitle ?? "",
                                  style: AppTextStyles.h2.copyWith(
                                    fontSize: 13.5.asp,
                                    height: 1.6,
                                    color: AppColors.rexTint400,
                                  ),
                                ),
                              ),
                            ],
                            if (showAccountBalance) ...[
                              const Text("Account Balance"),
                            ],
                            // if (showAccountBalance) ...[
                            //   const SmallAccountBalanceText(),
                            // ],
                          ],
                        ),
                      ),
                      suffixWidget ?? const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
