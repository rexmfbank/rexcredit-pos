import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/model/business_file_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/common/widgets/business_file_status_widget.dart';

class BusinessFileUploadWidget extends StatelessWidget {
  const BusinessFileUploadWidget({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.docStatus,
    required this.onPressed,
    required this.actionBtnText,
  });

  final String titleText;
  final String subtitleText;
  final BusinessFileStatus docStatus;
  final void Function()? onPressed;
  final String actionBtnText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: 16.0,
        bottom: 8.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              titleText,
              style: const TextStyle(color: AppColors.rexPurpleDark),
            ),
          ),
          const SizedBox(height: 8.0),
          _DecoratingContainer(
            showBorderRadius: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Text(
                subtitleText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          _DecoratingContainer(
            showBorderRadius: false,
            child: BusinessFileStatusWidget(docStatus: docStatus),
          ),
          TextButton.icon(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.rexBrown2,
              backgroundColor: AppColors.cardBrown,
              minimumSize: const Size.fromHeight(50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            icon: const Icon(
              Icons.description,
              color: AppColors.rexBrown2,
            ),
            label: Text(actionBtnText),
          ),
        ],
      ),
    );
  }
}

class _DecoratingContainer extends StatelessWidget {
  const _DecoratingContainer({
    required this.child,
    required this.showBorderRadius,
  });

  final Widget child;
  final bool showBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: showBorderRadius
            ? const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )
            : null,
      ),
      child: child,
    );
  }
}
