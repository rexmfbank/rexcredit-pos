import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardSavingsAppBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const DashboardSavingsAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(150.ah);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CustomAppBar(
      shouldHaveBackButton: false,
      title: StringAssets.saveTitle,
      subtitle: StringAssets.savingsSubtitle,
    );
  }
}
