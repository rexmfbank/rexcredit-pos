import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      children: [
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('1110344343'),
            Text('|'),
            Text('Olalade Mr Money'),
            Icon(Icons.copy),
          ],
        ),
        SizedBox(height: 4),
        Text("Book Balance: 500,563,670.00"),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: ContainerStyleButton(
                title: 'Transfer',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {},
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ContainerStyleButton(
                title: 'Add Money',
                bgColor: AppColors.rexWhite,
                textColor: AppColors.rexPurpleDark3,
                onTap: () {},
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
      ],
    );
  }
}
