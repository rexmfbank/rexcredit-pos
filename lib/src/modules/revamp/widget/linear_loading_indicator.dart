import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class LinearLoadingIndicator extends StatelessWidget {
  final bool loading;

  const LinearLoadingIndicator({required this.loading, super.key});

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LinearProgressIndicator(
          minHeight: 2,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.rexBlue),
        )
        : const SizedBox.shrink();
  }
}

class CircularLoader extends StatelessWidget {
  final double? height;
  final double? width;
  final double? strokeWidth;
  final Color? color;
  const CircularLoader({
    super.key,
    this.height,
    this.width,
    this.strokeWidth,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 5,
      width: width ?? 5,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 5,
          color: color ?? AppColors.rexPurpleLight,
          backgroundColor: Colors.grey.shade300,
          strokeCap: StrokeCap.round,
        ),
      ),
    );
  }
}
