import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RequestSentPage extends ConsumerWidget {
  final String title;
  final String info;
  final VoidCallback? onTap;
  const RequestSentPage({
    super.key,
    required this.title,
    required this.info,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppScaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: AppConstants.deviceHeight * 0.08),
              LottieBuilder.asset(
                AssetPath.successTick,
                height: 245.ah,
                fit: BoxFit.fill,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.textBlackTint,
                ),
              ),
              SizedBox(height: 15.ah),
              Text(
                info,
                textAlign: TextAlign.center,
                style: AppTextStyles.body1Regular.copyWith(
                  color: AppColors.textBlackTint,
                  letterSpacing: 0.6,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RexFlatButton(
              onPressed: onTap != null
                  ? () => onTap!.call()
                  : () =>ref.watch(cardNotifier.notifier).navigateToCardList(context),
              buttonTitle: StringAssets.done,
              backgroundColor: AppColors.rexPurpleLight,
            ),
            SizedBox(height: 15.ah),
          ],
        ),
      ),
    );
  }
}
