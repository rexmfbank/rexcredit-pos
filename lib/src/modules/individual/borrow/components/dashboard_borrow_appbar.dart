import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardBorrowAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const DashboardBorrowAppBar({super.key});

  @override
  Size get preferredSize => calculatePreferredSize(MediaQueryData.fromView(WidgetsBinding.instance.window));

  Size calculatePreferredSize(MediaQueryData mediaQueryData) {
    double screenHeight = mediaQueryData.size.height;
    double preferredHeight = screenHeight * 0.25;
    return Size.fromHeight(preferredHeight);
  }

  @override
  Widget build(BuildContext context) {
    return const RexAppBar(
      step: null,
      shouldHaveBackButton: false,
      title: StringAssets.borrowTitle,
      subtitle: StringAssets.borrowSubtitle,
    );
  }
}
