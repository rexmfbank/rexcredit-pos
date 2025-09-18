import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class UptimeDataSearchField extends StatelessWidget {
  const UptimeDataSearchField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.rexWhite,
          hintText: 'Search Bank',
          hintStyle: AppTextStyles.body2Regular.copyWith(
            color: AppColors.rexTint400,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.aw,
            vertical: 16.ah,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.aw),
            child: SvgPicture.asset(
              AssetPath.search,
              width: 20.aw,
              height: 20.ah,
              colorFilter: ColorFilter.mode(
                AppColors.rexTint400,
                BlendMode.srcIn,
              ),
            ),
          ),
          prefixIconConstraints: BoxConstraints(minWidth: 24.aw),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.ar),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.ar),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.ar),
            borderSide: BorderSide(color: Colors.transparent, width: 0.5.ar),
          ),
        ),
      ),
    );
  }
}

class UptimeSuccessBadge extends StatelessWidget {
  const UptimeSuccessBadge({super.key, required this.rate});

  final int rate;

  @override
  Widget build(BuildContext context) {
    final clampedRate = rate.clamp(0, 100);
    final progress = clampedRate / 100;

    return SizedBox(
      width: 50.aw,
      height: 50.aw,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 46.aw,
            height: 46.aw,
            child: CircularProgressIndicator(
              value: progress.toDouble(),
              strokeWidth: 4.aw,
              backgroundColor: AppColors.rexTint300,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.rexLightBlue3,
              ),
            ),
          ),
          Container(
            width: 40.aw,
            height: 40.aw,
            decoration: const BoxDecoration(
              color: AppColors.rexWhite,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$rate%',
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UptimeDataWidget extends StatelessWidget {
  const UptimeDataWidget({super.key, required this.uptimeData});

  final UptimeData uptimeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 12.ah),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              uptimeData.bankName,
              style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          UptimeSuccessBadge(rate: uptimeData.uptimePercent.toInt()),
        ],
      ),
    );
  }
}

class UptimeSearchEmpty extends StatelessWidget {
  const UptimeSearchEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.aw),
        child: Text(
          'No banks matched your search.',
          style: AppTextStyles.body2Regular.copyWith(
            color: AppColors.rexTint400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
