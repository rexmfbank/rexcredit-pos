import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension IntExtensions on int {
  // String toTimeString() {
  //   // Convert the timestamp to a DateTime
  //   DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(this);
  //   return processDate(dateTime);
  // }

  // String processDate(DateTime dateTime) {
  //
  //   for (int i = 0; i < 7; i++) {
  //     final now = DateTime.now();
  //     final nowFormat = DateFormat("MMM d y").format(now);
  //     final dateTimeFormat = DateFormat("MMM d y").format(dateTime);
  //     if (nowFormat == dateTimeFormat) {
  //       return DateFormat('H:mm').format(dateTime);
  //     }
  //     final subtractedNow =
  //         DateFormat("MMM d y").format(now.subtract(Duration(days: i)));
  //     if (dateTimeFormat == subtractedNow) {
  //       if (i == 1) {
  //         return 'Yesterday';
  //       }
  //       return '${i}d ago';
  //     }
  //   }
  //   return DateFormat("MMM d y").format(dateTime);
  // }

  Widget get width => spaceWidth();

  Widget get height => spaceHeight();

  Widget spaceWidth() {
    return SizedBox(
      width: toDouble(),
    );
  }

  String formatNumber() {
    final result = NumberFormat().format(this);
    return result;
  }

  Widget spaceHeight() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget divide({double thickness = 1}) {
    return Divider(
      color: Colors.black26,
      thickness: thickness,
      height: toDouble(),
    );
  }
}
