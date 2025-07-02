import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class LoadingIndicatorOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingIndicatorOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        if (isLoading)
          ModalBarrier(
            color: AppColors.rexPurpleLight.withOpacity(0.2),
            dismissible: false,
          ),
        if (isLoading)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ],
    );
  }
}
