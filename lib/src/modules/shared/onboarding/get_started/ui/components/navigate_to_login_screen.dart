import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/register_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:go_router/go_router.dart';

class NavigateToLoginScreen extends ConsumerWidget {
  const NavigateToLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RexRichText(
      title1: StringAssets.richText1,
      title2: StringAssets.richText2,
      onTap: () {
        ref.invalidate(registerProvider);
        context.go(RouteName.login);
      },
    );
  }
}
