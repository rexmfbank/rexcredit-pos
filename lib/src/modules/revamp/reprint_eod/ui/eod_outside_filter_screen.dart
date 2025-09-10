import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/provider/eod_pagination_notifier.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/ui_widgets/eod_filter_result.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';

class EODOutsideFilterScreen extends ConsumerWidget {
  const EODOutsideFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(eodPaginationProvider).overlayLoading,
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'End-Of-Day Transactions'),
      body: EODFilterResult(),
    );
  }
}
