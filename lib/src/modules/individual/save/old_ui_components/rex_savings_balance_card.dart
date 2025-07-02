// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RexSavingsBalanceCard extends ConsumerWidget {
  final String? cardTitle;
  final String? iconPath;
  final VoidCallback? onIconTap;
  final Color? backgroundColor;
  final String total;

  const RexSavingsBalanceCard({
    super.key,
    this.cardTitle,
    required this.total,
    this.iconPath,
    this.backgroundColor,
    this.onIconTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal:16.aw, vertical: 8.ah),
      padding: EdgeInsets.symmetric(horizontal: 24.aw, vertical: 22.ah),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16.ar),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardTitle ?? StringAssets.totalSavings,
                style: AppTextStyles.bodyRegularSize14,
              ),
              SizedBox(height: 8.ah),
              Text(
                total,
                style: AppTextStyles.h4.copyWith(
                  color: AppColors.rexPurpleDark,
                ),
              ),
            ],
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: onIconTap,
                child: Icon(
                  Icons.refresh,
                  size: 32.ar,
                  color: AppColors.rexTint700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
