import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

class HideBalanceSwitch extends ConsumerWidget {
  const HideBalanceSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          'Hide balance',
          style: TextStyle(
            color: AppColors.rexTint600,
            fontSize: 10,
          ),
        ),
        Transform.scale(
          scaleX: 0.7,
          scaleY: 0.6, // Adjust the scale factor to make the switch smaller
          child: Switch.adaptive(
            value: ref.watch(hideAccountProvider),
            onChanged: (bool value) {
              ref.read(hideAccountProvider.notifier).state = value;
            },
          ),
        )
      ],
    );
  }
}
