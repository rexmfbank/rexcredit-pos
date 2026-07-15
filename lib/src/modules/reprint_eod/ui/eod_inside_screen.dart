import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/reprint_eod/ui_widgets/eod_select_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class EODInsideScreen extends ConsumerWidget {
  const EODInsideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: "Print EOD",
        showProfileImage: false,
      ),
      body: EODSelectScreen(isOutside: false),
    );
  }
}
