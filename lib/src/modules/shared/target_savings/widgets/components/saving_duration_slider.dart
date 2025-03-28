import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/widgets/components/deposit_duration_slider.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SavingDurationSlider extends ConsumerStatefulWidget {
  const SavingDurationSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SavingDurationSliderState();
}

class _SavingDurationSliderState extends ConsumerState<SavingDurationSlider> {
  double sliderValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 24.0,
            bottom: 24,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              StringAssets.createSavingsPlanDurationAmountText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
        ),
        SliderTheme(
          data: durationSliderTheme,
          child: Slider.adaptive(
            value: sliderValue,
            max: 12,
            divisions: 12,
            label: '${sliderValue.round()} month',
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
              ref
                  .read(targetSavingProvider.notifier)
                  .setDurationSliderValue(value);
            },
          ),
        ),
        DurationSliderText(
          value: '${sliderValue.round()} month',
        ),
      ],
    );
  }
}
