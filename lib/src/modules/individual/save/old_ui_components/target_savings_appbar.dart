import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class TargetSavingsAppBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const TargetSavingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexAppBar(
      step: null,
      shouldHaveBackButton: true,
      title: StringAssets.targetSavingsTitle,
      subtitle: StringAssets.savingsSubtitle,
      hasActionButton: false,
      onActionButtonPressed: () {},
    );
  }
}
