import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class LinearLoadingIndicator extends StatelessWidget {
  final bool loading;

  const LinearLoadingIndicator({
    required this.loading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LinearProgressIndicator(
            minHeight: 2,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.rexBlue))
        : const SizedBox.shrink();
  }
}
