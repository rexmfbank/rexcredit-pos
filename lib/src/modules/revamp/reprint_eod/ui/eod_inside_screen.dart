import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/ui_widgets/eod_select_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

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
