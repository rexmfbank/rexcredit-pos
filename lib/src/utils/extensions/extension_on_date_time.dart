extension FormatDate on DateTime {
  /// returns a DateTime object in the format -> 'dd-mm-yyyy'
  String dateDDMMYYYY() {
    final local = toString().split(' ');
    String a1 = local[0];

    // e.g 2023-09-14
    // ....0123456789 -> indices
    String year = a1.substring(0, 4);
    String month = a1.substring(4, 8);
    String day = a1.substring(8);

    return "$day$month$year";
  }

  /// returns a DateTime object in the format -> 'yyyy-mm-dd'
  String dateYYYYMMDD() {
    final local = toString().split(' ');
    String a1 = local[0];

    // e.g 2023-09-14
    // ....0123456789 -> indices
    String year = a1.substring(0, 4);
    String month = a1.substring(4, 8);
    String day = a1.substring(8);

    return "$year$month$day";
  }

  /// returns a DateTime object in the format -> 'Jan 11, 1993'
  String dateTimeReadable() {
    final local = toString().split(' ');
    String a1 = local[0];
    String a2 = local[1].substring(0, 5);

    String year = a1.substring(0, 4);
    String month = a1.substring(5, 7);
    String day = a1.substring(8);
    String monthTitle = getMonthTitle(month);

    return "$monthTitle $day, $year : $a2";
  }

  String dateReadable() {
    final local = toString().split(' ');
    String a1 = local[0];

    String year = a1.substring(0, 4);
    String month = a1.substring(5, 7);
    String day = a1.substring(8);
    String monthTitle = getMonthTitle(month);

    return "$monthTitle $day, $year";
  }

  String dateReadable2() {
    final local = toString();
    String a1 = local[0];

    String year = a1.substring(0, 4);
    String month = a1.substring(5, 7);
    String day = a1.substring(8);
    String monthTitle = getMonthTitle(month);

    return "$monthTitle $day, $year";
  }
}

String getMonthTitle(String day) {
  switch (day) {
    case '01':
      return 'Jan';
    case '02':
      return 'Feb';
    case '03':
      return 'Mar';
    case '04':
      return 'Apr';
    case '05':
      return 'May';
    case '06':
      return 'Jun';
    case '07':
      return 'Jul';
    case '08':
      return 'Aug';
    case '09':
      return 'Sep';
    case '10':
      return 'Oct';
    case '11':
      return 'Nov';
    case '12':
      return 'Dec';
    default:
      return 'MTH';
  }
}

/// Returns a string value
extension NullableDateTimeExtensions on DateTime? {
  String daysFromNow() {
    if (this == null) {
      return ''; // or handle the null case accordingly
    }

    DateTime givenDate = this ?? DateTime.now();
    DateTime now = DateTime.now();

    Duration difference = givenDate.difference(now);
    int daysDifference = difference.inDays;

    return daysDifference.toString();
  }
}

extension NullableDateStringExtensions on String? {
  String daysFromNow() {
    if (this == null) {
      return ''; // or handle the null case accordingly
    }

    DateTime givenDate = DateTime.tryParse(this!) ?? DateTime.now();
    DateTime now = DateTime.now();

    Duration difference = givenDate.difference(now);
    int daysDifference = difference.inDays;

    return daysDifference.toString();
  }
}
