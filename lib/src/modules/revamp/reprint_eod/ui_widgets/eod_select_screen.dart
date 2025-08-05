import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/reprint_eod/ui_widgets/eod_select_start_date.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class EODSelectScreen extends StatelessWidget {
  const EODSelectScreen({super.key, required this.isOutside});

  final bool isOutside;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: 16.ah),
        EODDateStart(),
        SizedBox(height: 12.ah),
        RexElevatedButton(
          onPressed: () {
            if (isOutside) {
              context.push(Routes.eodFilterScreen);
            } else {
              context.push(
                "${Routes.dashboardIndividual}/${Routes.eodInsideFilterScreen}",
              );
            }
          },
          buttonTitle: 'Apply Filter',
        ),
      ],
    );
  }
}
