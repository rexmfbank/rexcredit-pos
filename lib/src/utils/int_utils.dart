import 'dart:math';

int parseInt(String value) {
  try {
    return int.parse(value);
  } catch (e) {
    // Handle the parsing error
    return 0;
  }
}

int parseInteger(String value) {
  value = value.replaceAll(',', ''); // Remove commas from the string
  int? parsedValue = int.tryParse(value);
  if (parsedValue != null) {
    return parsedValue;
  } else {
    return 1;
  }
}

int randRange({required int min, required int max}) => min + Random().nextInt(max - min);
