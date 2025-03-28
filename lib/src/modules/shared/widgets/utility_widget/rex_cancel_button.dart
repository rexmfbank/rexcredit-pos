import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexCancelButton extends StatelessWidget {
  final bool isBack;
  final VoidCallback? onPressed;
  const RexCancelButton({
    super.key,
    this.isBack = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? context.pop,
      child: Container(
        height: 32.ah,
        width: 32.aw,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.cancelGrey.withOpacity(0.4),
        ),
        child: Icon(
          Icons.close,
          size: 20.ar,
          color: AppColors.rexBlack,
        ),
      ),
    );
  }
}
