import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class ServiceProviderItem extends StatelessWidget {
  const ServiceProviderItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.biller,
  });

  final VoidCallback onTap;
  final bool isSelected;
  final Biller biller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54.h,
        width: 54.w,
        decoration: BoxDecoration(
          color: AppColors.rexWhite,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected ? AppColors.rexPurpleLight : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: SvgPicture.network(
          biller.logoUrl ?? "",
        ),
      ),
    );
  }
}
