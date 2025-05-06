import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RexCardTile extends StatelessWidget {
  final CardListDetails card;
  final VoidCallback? onTap;
  final bool showBlockedStatus;

  const RexCardTile({
    super.key,
    required this.card,
    this.onTap,
    this.showBlockedStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => onTap?.call(),
          child: SizedBox(
            child: card.cardImage.isBlank
                ? const SizedBox.shrink()
                : RexNetworkImage(
                    image: card.cardImage,
                    height: 217.ah,
                    width: AppConstants.deviceWidth,
                    useBorderRadius: true,
                    radius: AppConstants.size.tileBorderRadius,
                  ),
          ),
        ),
        InkWell(
          onTap: () => onTap?.call(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.ah, horizontal: 15.aw),
            width: AppConstants.deviceWidth,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppConstants.size.tileBorderRadius,
              ),
              // image: card.cardImage.isBlank
              //     ? null
              //     : DecorationImage(
              //         image: NetworkImage(card.cardImage!),
              //         fit: BoxFit.cover,
              //       ),
              //  color: AppColors.rexPurpleLight,
            ),
            /*child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 90.ah),
                Text(
                  card.maskedPan ?? '',
                  style: AppTextStyles.h5.copyWith(
                    color: AppColors.rexWhite,
                  ),
                ),
                SizedBox(height: 8.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '****',
                      style: AppTextStyles.body1Regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexWhite,
                      ),
                    ),
                    SizedBox(width: 73.aw),
                    Text(
                      StringAssets.expiresEnd,
                      style: AppTextStyles.body3Regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexWhite,
                      ),
                    ),
                    SizedBox(width: 9.aw),
                    Text(
                      DateFormat('M/yy')
                          .format(card.expiryDate ?? DateTime.now()),
                      style: AppTextStyles.body2Regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.rexWhite,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 19.ah),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200.aw,
                      child: Text(
                        card.virtualAccountName ?? 'N/a',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.rexWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (showBlockedStatus) ...[
                      Text(
                        card.isBlocked
                            ? StringAssets.blocked
                            : StringAssets.notBlocked,
                        style: AppTextStyles.body1Regular.copyWith(
                          color: AppColors.rexWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),*/
          ),
        ),
      ],
    );
  }
}
