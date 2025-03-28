import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';

class NavigateToLoginText extends StatelessWidget {
  const NavigateToLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: RexRichText(
        title1: '',
        title2: 'Back to Login',
        onTap: () {
          context.go(RouteName.login);
        },
      ),
    );
  }
}
