import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
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
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.ar),
        ),
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.aw, vertical: 15.ah),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: iconBackgroundColor,
                    child: Image.asset(iconPath),
                  ),
                  SizedBox(width: 8.aw),
                  Text(
                    titleText,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: AppColors.rexPurpleDark,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.ah),
              Padding(
                padding: EdgeInsets.only(
                  top: 8.ah,
                  bottom: 22.ah,
                  left: 8.aw,
                ),
                child: Text(
                  subtitleText,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: subtitleColor ?? AppColors.rexPurpleDark3,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 10.ah),
                decoration: BoxDecoration(
                  color: quickActionTextColor ?? AppColors.quickTextTint,
                  borderRadius: BorderRadius.all(Radius.circular(24.ar)),
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
            ],
          ),
        ),
      ),
    );

    // return Expanded(
    //   child: GestureDetector(
    //     onTap: onTap,
    //     child: Card(
    //       color: cardBackgroundColor,
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(16.0),
    //       ),
    //       elevation: 0,
    //       child: Padding(
    //         padding:
    //             const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 CircleAvatar(
    //                   backgroundColor: iconBackgroundColor,
    //                   child: Image.asset(iconPath),
    //                 ),
    //                 const SizedBox(width: 8.0),
    //                 Expanded(
    //                   child: Text(
    //                     titleText,
    //                     style: const TextStyle(
    //                       fontSize: 19,
    //                       fontWeight: FontWeight.w500,
    //                       color: AppColors.rexPurpleDark,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 8.0),
    //             Flexible(
    //               child: Padding(
    //                 padding: const EdgeInsets.only(
    //                   top: 8.0,
    //                   bottom: 32.0,
    //                   left: 8.0,
    //                 ),
    //                 child: Text(
    //                   subtitleText,
    //                   style: TextStyle(
    //                     height: 1.5,
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w500,
    //                     color: subtitleColor ?? Color(0xff0C2445),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 8.0),
    //             Flexible(
    //               child: Container(
    //                 padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    //                 decoration: BoxDecoration(
    //                   color: quickActionTextColor ??
    //                       Color.fromARGB(113, 255, 255, 255),
    //                   borderRadius: const BorderRadius.all(Radius.circular(24)),
    //                 ),
    //                 child: quickActionText != null
    //                     ? Text(
    //                         quickActionText!,
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       )
    //                     : const Text(
    //                         StringAssets.comingSoonText,
    //                         style: TextStyle(
    //                           fontWeight: FontWeight.w500,
    //                         ),
    //                       ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
