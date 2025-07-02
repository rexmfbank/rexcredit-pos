import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class QuickActionTile extends StatelessWidget{
  const QuickActionTile({
    super.key,
    required this.onTap,
    required this.cardBackgroundColor,
    required this.iconBackgroundColor,
    required this.titleText,
    required this.subtitleText,
    this.subtitleColor,
    required this.quickActionText,
    required this.iconPath,
    this.quickActionTextColor,
  });

  final void Function()? onTap;
  final Color cardBackgroundColor;
  final Color iconBackgroundColor;
  final String titleText;
  final String subtitleText;
  final Color? subtitleColor;
  final String? quickActionText;
  final Color? quickActionTextColor;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 10.aw, vertical: 15.ah),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: iconBackgroundColor,
                      radius: 15.ar,
                      child: Image.asset(iconPath),
                    ),
                    SizedBox(width: 5.aw),
                    Expanded(
                      child: Text(
                        titleText,
                        style: AppTextStyles.h5.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 8.ah),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 8.ah,
                      bottom: 32.ah,
                      left: 8.aw,
                    ),
                    child: Text(
                      subtitleText,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 12.asp,
                        fontWeight: FontWeight.w500,
                        color: subtitleColor ?? const Color(0xff0C2445),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.ah),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 10.ah),
                    decoration: BoxDecoration(
                      color: quickActionTextColor ??
                          const Color.fromARGB(113, 255, 255, 255),
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                    ),
                    child: quickActionText != null
                        ? Text(
                            quickActionText!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : const Text(
                            StringAssets.comingSoonText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}