import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_text_field.dart';

class LoginPhoneTab extends ConsumerWidget {
  const LoginPhoneTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    return Column(
      key: const ValueKey('phone_tab'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RexTextField(
          controller: state.twoPhone,
          outerTitle: 'Phone Number',
          showOuterTile: true,
          hintText: 'Enter Phone Number',
          inputType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          maxLength: 11,
          horizontalPadding: 0,
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        ),
        SizedBox(height: 4.ah),
        RexTextField(
          controller: state.twoPasscode,
          outerTitle: 'Passcode',
          showOuterTile: true,
          hintText: 'Enter 6-digit passcode',
          obscureText: true,
          maxLength: 6,
          inputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          horizontalPadding: 0,
        ),
        SizedBox(height: 8.ah),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () => context.push(Routes.forgotPasscode),
            child: Text(
              'Forgot Passcode?',
              style: TextStyle(
                fontSize: 12.asp,
                fontWeight: FontWeight.w600,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
