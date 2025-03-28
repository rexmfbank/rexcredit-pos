import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginScreenRegisterText extends StatelessWidget {
  const LoginScreenRegisterText({super.key});

  @override
  Widget build(BuildContext context) {
    return RexRichText(
      title1: StringAssets.richText3,
      title2: StringAssets.richText4,
      onTap: () {
        context.go(RouteName.selectCountry);
      },
    );
  }
}
