import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexRadioButton extends StatelessWidget {
  final String groupValue;
  final String value;
  final String title;
  final VoidCallback onTap;
  const RexRadioButton({
    super.key,
    required this.groupValue,
    required this.value,
    required this.title,
    required this.onTap,
  });

  bool get _selected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: _selected
                ? Icon(
                    Icons.radio_button_checked,
                    size: 20.ar,
                    color: AppColors.rexPurpleLight,
                  )
                : Icon(
                    Icons.radio_button_off,
                    size: 20.ar,
                    color: AppColors.cancelGrey,
                  ),
          ),
          SizedBox(width: 8.aw),
          Text(
            title,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
