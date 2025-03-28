import 'package:intl/intl.dart';

String getDateAfterMonths(int months) {
  final now = DateTime.now();
  final dateAfterMonths = DateTime(now.year, now.month + months, now.day);
  final formatter = DateFormat('yyyy-MM-dd');
  final formattedDate = formatter.format(dateAfterMonths);
  return formattedDate;
}

String getMonthString(String? dateString) {
  if (dateString == null) {
    return ' '; // or handle the null case accordingly
  }

  DateTime dateTime = DateTime.tryParse(dateString) ?? DateTime.now();
  return _getMonthAbbreviation(dateTime.month);
}

String getMonth(DateTime? date) {
  if (date == null) {
    return ' '; // or handle the null case accordingly
  }

  return _getMonthAbbreviation(date.month);
}

String getDayString(String? dateString) {
  if (dateString == null) {
    return ' '; // or handle the null case accordingly
  }
  DateTime dateTime = DateTime.tryParse(dateString) ?? DateTime.now();
  return dateTime.day.toString().padLeft(2, '0');
}

String getDay(DateTime? date) {
  if (date == null) {
    return ' '; // or handle the null case accordingly
  }
  return date.day.toString().padLeft(2, '0');
}

String _getMonthAbbreviation(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'Jul';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    case 12:
      return 'Dec';
    default:
      throw ArgumentError('Invalid month: $month');
  }
}
