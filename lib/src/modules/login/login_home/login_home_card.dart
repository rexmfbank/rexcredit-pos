import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/general/app_text_styles.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/container_style_button.dart';

class LoginHomeCard extends ConsumerStatefulWidget {
  const LoginHomeCard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginHomeCardState();
}

class _LoginHomeCardState extends ConsumerState<LoginHomeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              '1110344343 | Olalade Mr Money',
              style: AppTextStyles.body4Regular,
            ),
            Icon(Icons.copy),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text("\u20A6500,563,670.00", style: AppTextStyles.body4Regular),
            Icon(Icons.visibility),
          ],
        ),
        SizedBox(height: 4),
        Text("Book Balance: 500,563,670.00", style: AppTextStyles.body4Regular),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ContainerStyleButton(
                title: 'Transfer',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {
                  context.push(Routes.loginTransferPath);
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ContainerStyleButton(
                title: 'Add Money',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {
                  context.push(Routes.loginAddMoneyPath);
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
