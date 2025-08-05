import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/ui_widgets/eod_select_screen.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class EODOutsideScreen extends ConsumerWidget {
  const EODOutsideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: AppbarSubScreen(title: "Print EOD"),
      body: EODSelectScreen(isOutside: true),
    );
  }
}
