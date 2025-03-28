import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

import '../../../../utils/constants/asset_path.dart';

class UploadDocumentWidget extends StatelessWidget {
  const UploadDocumentWidget({
    super.key,
    this.fileTypes = '.csv',
    required this.onTap,
  });

  final String? fileTypes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              color: Colors.white,
              child: Center(
                child: Text(
                  StringAssets.onlyFileTypesAllowed(fileTypes!),
                  style: const TextStyle(color: AppColors.grey),
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xffF5EDE1),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AssetPath.docUploadIcon),
                  SizedBox(width: 8.w),
                  const Text(
                    StringAssets.uploadDocument,
                    style: TextStyle(color: Color(0xffC27C4D)),
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }
}
