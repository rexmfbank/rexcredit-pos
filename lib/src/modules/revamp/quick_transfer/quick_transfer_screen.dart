import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/utils/app_secure_storage.dart';
import 'package:rex_app/src/modules/revamp/widget/appbar_sub_screen.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class QuickTransferScreen extends ConsumerStatefulWidget {
  const QuickTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransferScreenState();
}

class _QuickTransferScreenState extends ConsumerState<QuickTransferScreen> {
  String acctNumber = '';

  @override
  void initState() {
    super.initState();
    getNubanAccount();
  }

  getNubanAccount() async {
    final str = await AppSecureStorage().getPosNuban();
    setState(() {
      acctNumber = str ?? 'N/A';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexWhite,
      appBar: AppbarSubScreen(title: 'Pay With Transfer'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
            ),
            child: Text(
              quickTransferHeader,
              style: TextStyle(color: AppColors.rexBlack),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexLightBlue4,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 8.ah),
                Text(
                  'Bank',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  'Rex MFB',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.ah),
                Text(
                  'Account Number',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  acctNumber,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.ah),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const quickTransferHeader =
    'Kindly share account number with customer to complete payment on mobile/internet banking app.';
