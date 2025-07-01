import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';

class QuickTransferScreen extends ConsumerStatefulWidget {
  const QuickTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransferScreenState();
}

class _QuickTransferScreenState extends ConsumerState<QuickTransferScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Pay with transfer'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
              border: Border.all(),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bank'),
                Text(
                  'Rex MFB',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text('Account Number'),
                Text(
                  '*******',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
