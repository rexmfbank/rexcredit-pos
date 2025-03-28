import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardEmployeeAppBar extends HookConsumerWidget
    implements PreferredSizeWidget {
  const DashboardEmployeeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const RexAppBar(
      step: null,
      shouldHaveBackButton: false,
      title: StringAssets.employeesText,
      subtitle: StringAssets.employeesAppbarSubtitle,
      hasActionButton: false,
    );
  }
}
