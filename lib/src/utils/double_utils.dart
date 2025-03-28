import 'dart:math';

double parseDouble(String value) {
  try {
    return double.parse(value);
  } catch (e) {
    // Handle the parsing error
    return 0.0;
  }
}

double getRandomPercentage() {
  final random = Random();
  return random.nextInt(100) + 1;
}
