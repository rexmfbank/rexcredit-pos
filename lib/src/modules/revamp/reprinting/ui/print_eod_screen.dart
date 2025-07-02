import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/int_ext.dart';
import 'package:rex_app/src/modules/revamp/reprinting/provider/reprint_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';

class PrintEodScreen extends ConsumerWidget {
  const PrintEodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reprintState = ref.watch(reprintProvider);
    //
    return AppScaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: "Print EOD",
        showProfileImage: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          15.spaceHeight(),
          Material(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Today's Date: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        DateTime.now().dateReadable(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "You made ${reprintState.todaysList.length} transactions today",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          15.spaceHeight(),
          RexFlatButton(
            backgroundColor: AppColors.rexTint400,
            onPressed: () {
              ref.read(reprintProvider.notifier).printEOD(context);
            },
            buttonTitle: "Print all receipt",
          ),
        ],
      ),
    );
  }
}
