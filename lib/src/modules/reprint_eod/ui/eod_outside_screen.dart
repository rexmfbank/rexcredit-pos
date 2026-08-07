import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/reprint_eod/ui_widgets/eod_select_screen.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class EODOutsideScreen extends ConsumerWidget {
  const EODOutsideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.zero,
      backgroundColor: AppColors.rexBackground,
      isLoading: ref.watch(eodPaginationProvider).overlayLoading,
      appBar: const AppbarSubScreen(title: 'Print EOD', centerTitle: true),
      body: const EODSelectScreen(isOutside: true),
    );
  }
}
