import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/reprinting/ui_widgets/eod_select_start_date.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EODOutsideScreen extends ConsumerStatefulWidget {
  const EODOutsideScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EODOutsideScreenState();
}

class _EODOutsideScreenState extends ConsumerState<EODOutsideScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppbarSubScreen(title: "Print EOD"),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          EODDateStart(),
          SizedBox(height: 12.ah),
          RexElevatedButton(
            onPressed: () => context.push(Routes.eodFilterScreen),
            buttonTitle: 'Apply Filter',
          ),
        ],
      ),
    );
  }
}
