import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/summary_divider.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class ReceiptRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? item;
  final CrossAxisAlignment? crossAlignment;
  final bool showDivider;
  const ReceiptRow({
    super.key,
    required this.title,
    this.subtitle = '',
    this.item,
    this.crossAlignment,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: crossAlignment ?? CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.body1Regular.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.8,
              ),
            ),
           subtitle.isNotBlank ? Align(
             alignment: Alignment.centerRight,
             child: Text(
               subtitle,
               textAlign: TextAlign.right,
               textDirection: TextDirection.rtl,
               overflow: TextOverflow.ellipsis,
               style: AppTextStyles.body1Regular,
             ),
           ): const SizedBox.shrink(),
            if(item != null)...[
              item!,
            ],
          ],
        ),
        if (showDivider) ...[
          const PlanSummaryDivider(),
        ],
      ],
    );
  }
}
