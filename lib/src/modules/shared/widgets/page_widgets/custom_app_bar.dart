import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/dashboard_personal/ui/components/small_account_balance_text.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

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
  });

  final bool? shouldHaveBackButton;
  final bool showImage;
  final bool showNotification;
  final bool showAccountBalance;
  final String title;
  final String? subtitle;
  final VoidCallback? onBackButtonPressed;
  final Widget? suffixWidget;

  @override
  Size get preferredSize => const Size.fromHeight(150.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.ah, horizontal: 12.aw),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0.aw),
                    child: Builder(builder: (context) {
                      if (shouldHaveBackButton!) {
                        return BackButton(
                          color: AppColors.rexPurpleDark,
                          onPressed: onBackButtonPressed,
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ),
                  Row(
                    children: [
                      if (showNotification) ...[
                        IconButton(
                          color: AppColors.rexPurpleDark,
                          onPressed: () =>
                              context.push(Routes.notificationPage),
                          icon: Image.asset(
                            AssetPath.notificationIconImage,
                          ),
                        ),
                        SizedBox(width: 7.aw),
                      ],
                      SizedBox(width: 7.aw),
                      if (showImage) ...[
                        InkWell(
                          onTap: () => context.push(
                            "${Routes.dashboardMore}/${Routes.profile}",
                          ),
                          child: RexNetworkImage(
                            image: ref
                                    .watch(loginProvider)
                                    .loginResponse
                                    .value
                                    ?.data
                                    .photoLinks ??
                                '',
                            shape: BoxShape.circle,
                            useBorderRadius: false,
                            height: 40.ah,
                            width: 40.aw,
                          ),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.h1.copyWith(
                          color: AppColors.rexPurpleLight,
                        ),
                      ),
                      if (subtitle.isNotBlank) ...[
                        SizedBox(height: 2.ah),
                        Flexible(
                          child: SizedBox(
                            width: 240.aw,
                            child: Text(
                              subtitle!,
                              style: AppTextStyles.h2.copyWith(
                                fontSize: 13.asp,
                                color: AppColors.rexTint400,
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (showAccountBalance) ...[
                        const SmallAccountBalanceText(),
                      ],
                    ],
                  ),
                  suffixWidget ?? const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
