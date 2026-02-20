import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class AppVersionText extends StatefulWidget {
  const AppVersionText({super.key});

  @override
  State<AppVersionText> createState() => _AppVersionTextState();
}

class _AppVersionTextState extends State<AppVersionText> {
  late PackageInfo appVersion;
  ValueNotifier<bool> completed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    setUpPackageInfo();
  }

  Future<void> setUpPackageInfo() async =>
      appVersion = await PackageInfo.fromPlatform().then((value) {
        completed.value = true;
        return value;
      });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: completed,
      builder: (context, bool comp, _) {
        return Align(
          alignment: Alignment.center,
          child: Text(
            comp ? 'version: ${appVersion.version}' : '',
            style: AppTextStyles.body3Regular.copyWith(
              color: AppColors.textGrey,
              fontSize: 14.sp,
            ),
          ),
        );
      },
    );
  }
}
