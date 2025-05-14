import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/pin_input_layout.dart';
import 'package:rex_app/src/modules/shared/providers/get_security_question_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class EnterTransactionPinSecurityQuestionScreen extends ConsumerWidget {
  const EnterTransactionPinSecurityQuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String pin = '';

    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: null,
        title: StringAssets.enterTransactionPinTitle,
        subtitle: StringAssets.enterTransactionPinSubtitle,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: PinInputLayout(
              onPinEntered: (String value) {
                pin = value;
                ref
                    .read(securityQuestionListProvider.notifier)
                    .getSecurityQuestionList();
                context.go(
                    '${Routes.dashboardMoreBusiness}/${Routes.businessSecurityQuestion}');
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
