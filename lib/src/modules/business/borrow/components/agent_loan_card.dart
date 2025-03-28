import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoanActionCard extends StatelessWidget {
  const LoanActionCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.rexWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: const Color(0xFFBDBDBD),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.rexBlack,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoanDashboardCard extends StatelessWidget {
  const LoanDashboardCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.rexPurpleLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringAssets.loanAmount,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
            ),
          ),
          Text(
            '₦ 100,000.00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            StringAssets.loanLimit(150000.00, '₦'), //Todo rename
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              minHeight: 4,
              backgroundColor: Colors.white,
              color: AppColors.rexPurpleLight,
              value: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              StringAssets.availableLoan(500.0, '₦'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoanProductCard extends StatelessWidget {
  const LoanProductCard({
    Key? key,
    required this.onApplyClicked,
  }) : super(key: key);

  final VoidCallback onApplyClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutralGrey),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SLS Microfinance Bank',
                      style: TextStyle(
                        color: AppColors.textBlack,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '0.3% Interest   |   30 days',
                      style: TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
                width: 80.w,
                child: CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/200/300',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '₦5000',
                    style: TextStyle(
                      color: AppColors.textBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    StringAssets.maximumAmount,
                    style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: 55.h,
                width: 74.w,
                child: RexFlatButton(
                  onPressed: onApplyClicked,
                  buttonTitle: StringAssets.apply,
                  backgroundColor: AppColors.rexPurpleLight,
                  radius: 6.r,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LoanProductsBuilder extends StatelessWidget {
  const LoanProductsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => LoanProductCard(
        onApplyClicked: () {
          context.push(
              '${RouteName.dashboardBorrowBusiness}/${RouteName.agentLoanRequest}');
        },
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: 10,
    );
  }
}
