import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BankUptimeCard extends StatelessWidget {
  const BankUptimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw),
        child: TextButton.icon(
          style: TextButton.styleFrom(
            shape: const ContinuousRectangleBorder(
              side: BorderSide(color: AppColors.rexPurpleDark3),
            ),
          ),
          onPressed: () => context
              .push("${Routes.dashboardIndividual}/${Routes.bankUptime}"),
          icon: const Icon(
            Icons.navigate_before,
            color: AppColors.rexBlack,
          ),
          label: Text(
            StringAssets.uptimeCardText,
            style: AppTextStyles.h3b,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}
