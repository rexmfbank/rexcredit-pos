import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

class QuickTransferScreen extends ConsumerStatefulWidget {
  const QuickTransferScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuickTransferScreenState();
}

class _QuickTransferScreenState extends ConsumerState<QuickTransferScreen> {
  String acctNumber = '';
  String acctName = '';

  @override
  void initState() {
    super.initState();
    getNubanAccount();
  }

  getNubanAccount() {
    final config = AppKeysStorage.getConfig();
    final str = config.baasNuban;
    final name = config.baasNubanName;
    setState(() {
      acctNumber = str;
      acctName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.rexBackground,
      appBar: AppbarSubScreen(title: 'Pay with Transfer'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexWhite,
            ),
            child: Text(
              Strings.quickTransferHeader,
              style: TextStyle(color: AppColors.rexBlack, fontSize: 12),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.rexPurpleLight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.ah),
                Text(
                  'MERCHANT NAME',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.rexWhite,
                  ),
                ),
                Text(
                  acctName,
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexWhite,
                  ),
                ),
                DashedDivider(),
                Text(
                  'BANK NAME',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.rexWhite,
                  ),
                ),
                Text(
                  'REX MFB',
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexWhite,
                  ),
                ),
                DashedDivider(),
                SizedBox(height: 8.ah),
                Text(
                  'ACCOUNT NUMBER',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColors.rexWhite,
                  ),
                ),
                Text(
                  acctNumber,
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.rexWhite,
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

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 4.0;
          const dashHeight = 1.0;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();

          return Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.rexWhite),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
