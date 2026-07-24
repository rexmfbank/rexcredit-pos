import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_new/rex_tab_view.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_ext_provider.dart';
import 'package:rex_app/src/modules/transfer/provider/transfer_int_provider.dart';
import 'package:rex_app/src/modules/transfer/transfer_new/transfer_external_tab.dart';
import 'package:rex_app/src/modules/transfer/transfer_new/transfer_internal_tab.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_dialogs.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

class TransferNewScreen extends ConsumerStatefulWidget {
  const TransferNewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransferNewScreenState();
}

class _TransferNewScreenState extends ConsumerState<TransferNewScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final transferExt = ref.watch(transferExtProvider);
    final transferInt = ref.watch(transferIntProvider);
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      isLoading: transferExt.isLoading || transferInt.isLoading,
      padding: EdgeInsets.all(0),
      resizeToAvoidBottomInset: true,
      appBar: AppbarSubScreen(title: 'Transfer money'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 8),
          RexTabView(
            tabLabels: const ['Other Banks', 'To Rex'],
            tabViews: [TransferExternalTab(), TransferInternalTab()],
            onTabChanged: (value) {
              setState(() {
                tabIndex = value;
              });
            },
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () async {
                final pin = await showPinDialog(context: context);
                if (pin != null) {
                  tabIndex == 0
                      ? ref
                          .read(transferExtProvider.notifier)
                          .interbankTransfer(pin, context)
                      : ref
                          .read(transferIntProvider.notifier)
                          .internalTransfer(pin, context);
                }
              },
              buttonTitle: 'Confirm',
            ),
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
