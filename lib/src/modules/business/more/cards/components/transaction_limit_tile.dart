import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TransactionLimitTile extends ConsumerWidget {
  final double startingValue;
  final double endingValue;
  final double currentValue;
  final Function(double) onChanged;
  final String title;
  const TransactionLimitTile({
    super.key,
    required this.title,
    required this.startingValue,
    required this.endingValue,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.body2Regular.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.ah),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringAssets.fromText,
                    style: AppTextStyles.body3Regular.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 12.ah),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 7.ah, horizontal: 12.aw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.ar),
                      border: Border.all(
                        width: 0.5.aw,
                        color: AppColors.textGreyLight,
                      ),
                    ),
                    child: Text(
                      startingValue.toStringAsFixed(2),
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.textGreyLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 23.aw),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringAssets.toText,
                    style: AppTextStyles.body3Regular.copyWith(
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 12.ah),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 7.ah, horizontal: 12.aw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.ar),
                      border: Border.all(
                        width: 0.5.aw,
                        color: AppColors.textGreyLight,
                      ),
                    ),
                    child: Text(
                      currentValue.toStringAsFixed(2),
                      style: AppTextStyles.body2Regular.copyWith(
                        color: AppColors.textGreyLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 13.ah),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 4.ah,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.ar),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 12.ar),
          ),
          child: Slider(
            min: startingValue,
            max: endingValue,
            activeColor: AppColors.rexPurpleLight,
            inactiveColor: AppColors.textGreyLight,
            thumbColor: AppColors.rexWhite,
            value: currentValue,
            onChanged: (value) => onChanged(value),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.ah),
          child: Divider(
            thickness: 0.5.ah,
            color: AppColors.dividerGreyLight,
          ),
        ),
      ],
    );
  }
}
