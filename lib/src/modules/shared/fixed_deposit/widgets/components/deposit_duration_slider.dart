import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/fixed_deposit/providers/fixed_deposit_notifier.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class DepositDurationSlider extends ConsumerStatefulWidget {
  const DepositDurationSlider({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DepositDurationSliderState();
}

class _DepositDurationSliderState extends ConsumerState<DepositDurationSlider> {
  final durationList = ['60', '90', '180', '270', '360'];
  double sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DurationSliderTitle(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SliderTheme(
              data: durationSliderTheme,
              child: Slider.adaptive(
                value: sliderValue,
                max: (durationList.length - 1).toDouble(),
                divisions: durationList.length - 1,
                label: '${durationList[sliderValue.round()]} days',
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                  print('SLIDER- sliderValue: $sliderValue = value $value');
                  ref
                      .read(fixedDepositProvider.notifier)
                      .setDepositDuration(durationList[sliderValue.round()]);
                },
              ),
            ),
            DurationSliderText(
              value: '${durationList[sliderValue.round()]} days'.monthString(),
            ),
          ],
        ),
      ],
    );
  }
}

class DurationSliderText extends StatelessWidget {
  const DurationSliderText({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        top: 4.0,
        bottom: 4.0,
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class DurationSliderTitle extends StatelessWidget {
  const DurationSliderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 24.0,
        bottom: 24,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'For How Long?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: AppColors.rexPurpleDark,
          ),
        ),
      ),
    );
  }
}

class DisabledDurationSlider extends StatelessWidget {
  const DisabledDurationSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: durationSliderTheme,
      child: const Slider.adaptive(
        min: 0,
        max: 0,
        value: 0,
        onChanged: null,
      ),
    );
  }
}

final durationSliderTheme = SliderThemeData(
  activeTrackColor: AppColors.rexGreen,
  thumbColor: AppColors.rexGreen,
  overlayColor: AppColors.rexGreen.withOpacity(0.2),
  valueIndicatorColor: AppColors.rexGreen,
  showValueIndicator: ShowValueIndicator.always,
  valueIndicatorTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 10.0,
  ),
);
