import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/providers/get_security_question_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard.dart';
import 'package:rex_app/src/modules/shared/widgets/custom_keyboard_theme.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_error_dialog.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

class EnterTransactionPinScreen extends ConsumerWidget {
  const EnterTransactionPinScreen({super.key});

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
      body: Column(
        children: [
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: Lottie.asset('assets/lottiefiles/password_lock.json'),
          ),
          Expanded(
            child: CustomKeyBoard(
              maxLength: 4,
              pinTheme: CustomKeyboardTheme(
                submitColor: AppColors.rexBlack,
                textColor: AppColors.rexBlack,
                keysColor: AppColors.rexBlack,
              ),
              onChanged: (value) {
                if (kDebugMode) {
                  print(value);
                }
                pin = value;
              },
              onbuttonClick: () {
                // context.go(RouteName.confirmTransactionPin);
                if (pin.length < 4) {
                  showRexErrorDialog(
                      context: context, errorText: 'Enter a valid PIN');
                } else {
                  ref
                      .read(securityQuestionListProvider.notifier)
                      .getSecurityQuestionList();
                  context.go(
                    "${Routes.dashboardMore}/${Routes.securityQuestion}",
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
