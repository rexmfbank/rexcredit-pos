import 'package:intl/intl.dart';

String changeDateFormat(
    String currentDateFormat, String requiredDateFormat, String dateToFormat) {
  try {
    final currentDateFormatInstance = DateFormat(currentDateFormat);
    final newDate = currentDateFormatInstance.parseStrict(dateToFormat);

    final requiredDateFormatInstance = DateFormat(requiredDateFormat);
    return requiredDateFormatInstance.format(newDate);
  } catch (e) {
    // Handle the exception or return a default value
    return dateToFormat;
  }
}

String? convertApiTimestampToDate(String? timestamp) {
  if (timestamp != null) {
    DateTime dateTime = DateTime.parse(timestamp);
    // Format the DateTime as '29th June, 2023'
    String formattedDate = DateFormat('d MMMM, yyyy').format(dateTime);
    return formattedDate;
  } else {
    return null;
  }
}

String? convertDateTimeTodMMMMyyyyFormat(DateTime? dateTime) {
  if (dateTime != null) {
    String formattedDate = DateFormat('d MMMM, yyyy').format(dateTime);
    return formattedDate;
  }
  return null;
}

String? convertDateTimeToyyyymmddFormat(DateTime? dateTime) {
  if (dateTime != null) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    return formattedDate;
  }
  return null;
}

String daysFromNow(String dateString) {
  DateTime givenDate = DateTime.parse(dateString);
  DateTime now = DateTime.now();

  Duration difference = now.difference(givenDate);
  int daysDifference = difference.inDays;

  return daysDifference.toString();
}
