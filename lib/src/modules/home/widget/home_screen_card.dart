import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.onTap,
    required this.label,
    required this.bgColor,
    required this.iconPath,
  });

  final Function()? onTap;
  final String label;
  final Color bgColor;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: SizedBox(
          width: 80,
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(iconPath),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.homeCardTheme(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
