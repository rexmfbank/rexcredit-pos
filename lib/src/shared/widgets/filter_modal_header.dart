import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class FilterModalHeader extends StatelessWidget {
  const FilterModalHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.titleSize18),
            GestureDetector(
              onTap: () => context.pop(),
              child: Image.asset(AssetPath.closeCircularIcon),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            textAlign: TextAlign.left,
            style: AppTextStyles.titleSize14,
          ),
        ),
      ],
    );
  }
}
