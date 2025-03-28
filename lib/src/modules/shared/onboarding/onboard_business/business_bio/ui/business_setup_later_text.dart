import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessSetupLaterText extends StatelessWidget {
  const BusinessSetupLaterText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalActionSuccess(
          context: context,
          isDismissible: true,
          title: StringAssets.setupLater1,
          subtitle: StringAssets.setupLater2,
          onPressed: () {
            context.go(RouteName.login);
          },
        );
      },
      child: const Text(
        StringAssets.willDoLater,
        textAlign: TextAlign.center,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.rexPurpleLight,
        ),
      ),
    );
  }
}
