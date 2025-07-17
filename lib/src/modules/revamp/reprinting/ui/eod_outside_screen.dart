import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';

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
      body: Column(
        children: [
          RexElevatedButton(onPressed: () {}, buttonTitle: 'Apply Filter'),
        ],
      ),
    );
  }
}
