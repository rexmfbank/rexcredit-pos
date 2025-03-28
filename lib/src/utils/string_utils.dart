import 'dart:math';

String generateProductCode({required String name}) {
  Random random = Random();
  int randomNumber = random.nextInt(900000) + 100000;
  return '$name-$randomNumber';
}

String generateExternalRefNo() {
  return Random().nextInt(99999999).toString().padLeft(12, '0');
}

extension StringTitleCaseExtension on String? {
  String? toTitleCase() {
    if (this == null) {
      return null;
    }

    return this!.toLowerCase().replaceAllMapped(
        RegExp(
            r'[A-Z]{2,}(?=[A-Z][a-z]+[0-9]*|\b)|[A-Z]?[a-z]+[0-9]*|[A-Z]|[0-9]+'),
        (Match match) {
      return "${match[0]?[0].toUpperCase()}${match[0]?.substring(1).toLowerCase()}";
    }).replaceAll(RegExp(r'(_|-)+'), ' ');
  }
}
