import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class UpdateAvailableApp extends ConsumerWidget {
  const UpdateAvailableApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 0.ah,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.ah),
          Image.asset(
            AssetPath.updateAppIllustration,
            height: 400.ah,
          ),
          SizedBox(height: 20.ah),
          Text(
            StringAssets.anUpdateIsAvailable,
            style: AppTextStyles.h4,
          ),
          SizedBox(height: 8.ah),
          Text(
            StringAssets.pleaseClickToUpdate,
            style: AppTextStyles.body2Regular,
          ),
          SizedBox(height: 30.ah),
          RexElevatedButton(
            onPressed: () {},
            buttonTitle: StringAssets.updateTextOnButton,
          ),
        ],
      ),
    );
  }
}
