import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_new/login_new_header.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_passcode_field.dart';

/// Login body shown once the terminal has a saved identifier: the user only
/// supplies the passcode.
class LoginPasscodeBody extends ConsumerWidget {
  const LoginPasscodeBody({super.key, required this.savedUsername});

  final String savedUsername;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(height: 16.ah),
        LoginNewHeader(subtitle: maskLoginIdentifier(savedUsername)),
        SizedBox(height: 24.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.aw),
          child: RexPasscodeField(
            controller: state.onePasscode,
            outerTitle: 'Passcode',
            hintText: 'Enter 6-digit passcode',
            textInputAction: TextInputAction.done,
            autoFocus: true,
          ),
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
        SizedBox(height: 16.ah),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.aw),
          child: RexElevatedButton(
            onPressed: () {
              ref.read(loginProvider.notifier).validate();
            },
            buttonTitle: 'Continue',
          ),
        ),
        SizedBox(height: 24.ah),
      ],
    );
  }
}

const _mask = '•••';

/// Partially hides a saved email address or phone number, e.g.
/// `jo•••@mail.com` or `080•••3434`.
String maskLoginIdentifier(String value) {
  final identifier = value.trim();
  if (identifier.isEmpty) return identifier;

  final atIndex = identifier.indexOf('@');
  if (atIndex > 0) {
    final local = identifier.substring(0, atIndex);
    final domain = identifier.substring(atIndex);
    final visible = local.length > 2 ? local.substring(0, 2) : local[0];
    return '$visible$_mask$domain';
  }

  if (identifier.length < 8) return '${identifier[0]}$_mask';
  final head = identifier.substring(0, 3);
  final tail = identifier.substring(identifier.length - 4);
  return '$head$_mask$tail';
}
