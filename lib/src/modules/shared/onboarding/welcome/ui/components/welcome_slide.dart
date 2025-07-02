import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/models/welcome_model.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/provider/welcome_page_view_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_double_back_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WelcomeSlide extends ConsumerWidget {
  const WelcomeSlide({
    super.key,
    required this.welcomeModel,
    required this.pageController,
  });

  final WelcomeModel welcomeModel;
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(welcomePageViewProvider);
    //
    return Container(
      color: welcomeModel.color,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw),
        child: Column(
          children: [
            SizedBox(height: 48.ah),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(right: index == 3 ? 0 : 4.aw),
                  child: Container(
                    height: 4.ah,
                    width: 82.aw,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.ar),
                      color: (pageIndex >= index)
                          ? AppColors.rexWhite
                          : AppColors.rexWhite.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.ah),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    welcomeModel.titleIconPath,
                    height: 24.ah,
                    width: 24.aw,
                    color: pageIndex % 2 == 0
                        ? AppColors.rexPurpleDark
                        : AppColors.rexWhite,
                  ),
                  SizedBox(width: 8.aw),
                  Text(
                    welcomeModel.titleText,
                    style: AppTextStyles.h5.copyWith(
                      letterSpacing: 0.1,
                      color: pageIndex % 2 == 0
                          ? AppColors.rexPurpleDark
                          : AppColors.rexWhite,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.ah),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 283.aw,
                child: Text(
                  welcomeModel.descriptionText,
                  style: AppTextStyles.h1.copyWith(
                    //height: 0.8,
                    letterSpacing: 1.0,
                    color: pageIndex % 2 == 0
                        ? AppColors.rexPurpleDark
                        : AppColors.rexWhite,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.ah),
            const Spacer(),
            Image.asset(
              welcomeModel.imagePath,
              height: 320.ah,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            RexBackDoubleButton(
              onBackPressed: () => pageIndex == 0
                  ? context.showToast(message: StringAssets.noActionCapable)
                  : ref
                      .watch(welcomeNotifier)
                      .walkthroughController
                      .previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      ),
              onPressed: () => pageIndex == 3
                  ? context.go(Routes.register)
                  : ref.watch(welcomeNotifier).walkthroughController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      ),
              backgroundColor: null,
              backButtonColor: AppColors.rexWhite,
              buttonTitle: pageIndex == 3
                  ? StringAssets.getStartedTextOnButton
                  : StringAssets.nextTextOnButton,
            ),
            SizedBox(height: 20.ah),
          ],
        ),
      ),
    );
  }
}
