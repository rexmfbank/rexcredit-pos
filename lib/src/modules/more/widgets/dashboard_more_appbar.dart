import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/transfer/widgets/custom_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardMoreAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DashboardMoreAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(150.0);

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      shouldHaveBackButton: false,
      title: Strings.moreTitle,
      subtitle: Strings.moreSubtitle,
      showNotification: false,
    );
  }
}
