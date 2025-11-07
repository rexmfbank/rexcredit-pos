import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String convertDateToReadableDate(
  String dateToFormat,
  String currentFormat,
  bool isOtherFormat,
) {
  int hour = 0;
  int currentHour = 0;
  int min = 0;
  int sec = 0;
  String convertedDayName = '';
  String convertedDayNum = '';
  String convertedMonthName = '';
  String convertedYear = '';
  bool isPreviousDate = false;

  if (dateToFormat.isNotEmpty) {
    DateTime currentDate = DateTime.now();
    int numberOfMillisecondPassed = 0;
    double millisecond = 86400000.0; // 1 day is 86400000 milliseconds
    double numberOfDayPass = 0.0;
    DateFormat currentDateFormat = DateFormat(currentFormat);

    try {
      DateTime newDate = currentDateFormat.parse(dateToFormat);

      if (currentDate.isAfter(newDate)) {
        numberOfMillisecondPassed =
            currentDate.difference(newDate).inMilliseconds;
        isPreviousDate = true;
      } else {
        numberOfMillisecondPassed =
            newDate.difference(currentDate).inMilliseconds;
        isPreviousDate = false;
      }

      hour = int.parse(DateFormat('HH').format(newDate));
      currentHour = int.parse(DateFormat('HH').format(currentDate));
      min = int.parse(DateFormat('mm').format(newDate));
      sec = int.parse(DateFormat('ss').format(newDate));
      convertedDayName = DateFormat('EEEE').format(newDate);
      convertedDayNum = DateFormat('dd').format(newDate);
      convertedMonthName = DateFormat('MMM').format(newDate);
      convertedYear = DateFormat('yyyy').format(newDate);
    } catch (exception) {
      //
    }

    numberOfDayPass = numberOfMillisecondPassed / millisecond;

    if (numberOfDayPass < 1) {
      if (isOtherFormat) {
        return isPreviousDate
            ? '${currentHour - hour} hour(s)'
            : '${hour - currentHour} hour(s)';
      } else {
        return isPreviousDate
            ? 'Matured ${currentHour - hour} hours ago'
            : 'Matures in ${hour - currentHour} hours';
      }
    } else if (numberOfDayPass >= 1 && numberOfDayPass < 7) {
      if (isOtherFormat) {
        return '${numberOfDayPass.round()} day(s)';
      } else {
        return isPreviousDate
            ? 'Matured ${numberOfDayPass.round()} days ago'
            : 'Matures in ${numberOfDayPass.round()} days';
      }
    } else if (numberOfDayPass >= 7 && numberOfDayPass < 30) {
      double weeks = numberOfDayPass / 7;
      if (isOtherFormat) {
        return '${weeks.round()} week(s)';
      } else {
        if (weeks.round() > 1) {
          return isPreviousDate
              ? 'Matured ${weeks.round()} weeks ago'
              : 'Matures in ${weeks.round()} weeks';
        } else {
          return isPreviousDate
              ? 'Matured ${weeks.round()} week ago'
              : 'Matures in ${weeks.round()} week';
        }
      }
    } else if (numberOfDayPass >= 30 && numberOfDayPass < 360) {
      double months = numberOfDayPass / 30;
      if (isOtherFormat) {
        return '${months.round()} month(s)';
      } else {
        if (months.round() > 1) {
          return isPreviousDate
              ? 'Matured ${months.round()} months ago'
              : 'Matures in ${months.round()} months';
        } else {
          return isPreviousDate
              ? 'Matured ${months.round()} month ago'
              : 'Matures in ${months.round()} month';
        }
      }
    } else if (numberOfDayPass >= 360) {
      double years = numberOfDayPass / 360;
      return isOtherFormat
          ? '${years.round()} year(s)'
          : (years.round() > 1
              ? '${years.round()} years'
              : '${years.round()} year');
    } else {
      return '$convertedDayName $convertedDayNum $convertedMonthName $convertedYear $hour:$min:$sec';
    }
  } else {
    return '';
  }
}
