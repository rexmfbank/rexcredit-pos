import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class CustomSavingsDurationSlider extends StatelessWidget {
  final double min;
  final double max;
  final double value;
  final Color? color;
  final ValueChanged<double>? onChanged;

  const CustomSavingsDurationSlider({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    this.color = AppColors.rexGreen,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: color,
        thumbColor: color,
        overlayColor: color?.withOpacity(0.2),
        valueIndicatorColor: color,
        showValueIndicator: ShowValueIndicator.always,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 10.0,
        ),
      ),
      child: Slider(
        min: min,
        max: max,
        value: value,
        label: '${value.round()} months',
        onChanged: onChanged,
      ),
    );
  }
}
