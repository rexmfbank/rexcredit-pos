import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class SelectCountryLoginText extends StatelessWidget {
  const SelectCountryLoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return RexRichText(
      title1: StringAssets.richText1,
      title2: StringAssets.loginTextonButton,
      onTap: () {
        context.push(Routes.login);
      },
    );
  }
}
