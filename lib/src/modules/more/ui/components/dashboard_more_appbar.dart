import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
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
      title: StringAssets.moreTitle,
      subtitle: StringAssets.moreSubtitle,
    );
  }
}
