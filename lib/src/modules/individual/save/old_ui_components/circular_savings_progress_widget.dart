import 'package:flutter/material.dart';

class CircularSavingsProgressWidget extends StatelessWidget {
  final double percentage;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final double? width;
  final double? size;

  const CircularSavingsProgressWidget(
      {Key? key,
      required this.percentage,
      this.backgroundColor,
      this.indicatorColor,
      this.width,
      this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = percentage / 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: SizedBox(
        height: size ?? 80.0,
        width: size ?? 80.0,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircularProgressIndicator(
              value: progress,
              strokeWidth: width ?? 6.0,
              backgroundColor: backgroundColor ?? Colors.white.withOpacity(0.8),
              valueColor: AlwaysStoppedAnimation<Color>(
                indicatorColor ?? Colors.blueAccent.withOpacity(0.7),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                '${percentage.toInt()}%',
                style: TextStyle(
                    color: indicatorColor ?? Colors.blueAccent.withOpacity(0.7),
                    fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
