import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class RexDottedLine extends StatelessWidget {
  final double? dashLength;
  final double? gapLength;
  final double? lineThickness;
  final double? lineRadius;
  final Color? color;
  const RexDottedLine({
    super.key,
    this.dashLength,
    this.gapLength,
    this.lineThickness,
    this.lineRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      dashLength: dashLength ?? 4.0,
      lineThickness: lineThickness ?? 1.0,
      dashGapLength: gapLength ?? 4.0,
      dashRadius: lineRadius ?? 0,
      dashColor: color ?? AppColors.rexBlack,
    );
  }
}
