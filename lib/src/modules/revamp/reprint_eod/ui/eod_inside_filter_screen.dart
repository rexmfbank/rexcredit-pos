import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/ui_widgets/eod_filter_result.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';

class EODInsideFilterScreen extends ConsumerWidget {
  const EODInsideFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      padding: EdgeInsets.all(0),
      backgroundColor: AppColors.rexBackground,
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: 'End-Of-Day Transactions',
        showProfileImage: false,
      ),
      body: EODFilterResult(),
    );
  }
}
