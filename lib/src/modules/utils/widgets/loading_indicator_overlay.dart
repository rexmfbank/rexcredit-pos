import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:skeletonsplus/skeletonsplus.dart';

class LoadingIndicatorOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicatorOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading)
          ModalBarrier(
            color: AppColors.rexPurpleLight.withValues(alpha: 0.2),
            dismissible: false,
          ),
        if (isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 4)),
      ],
    );
  }
}

class SingleShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const SingleShimmer({
    super.key,
    this.height = 30,
    this.width = 0.0,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        width: width == 0.0 ? MediaQuery.of(context).size.width : width,
        height: height,
        randomHeight: false,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
