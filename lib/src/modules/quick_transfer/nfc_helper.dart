import 'dart:convert';

String convertHexToData(String hexString) {
  List<int> bytes = [];
  for (int i = 0; i < hexString.length; i += 2) {
    bytes.add(int.parse(hexString.substring(i, i + 2), radix: 16));
  }

  try {
    int startIndex = -1;
    for (int i = 0; i < bytes.length - 2; i++) {
      if (bytes[i] == 0x02 && bytes[i + 1] == 0x65 && bytes[i + 2] == 0x6E) {
        startIndex = i + 3;
        break;
      }
    }
    if (startIndex == -1) {
      return "Could not find standard text record format.";
    }
    int endIndex = bytes.indexOf(0xFE, startIndex);
    if (endIndex == -1) {
      endIndex = bytes.length;
    }
    return utf8
        .decode(bytes.sublist(startIndex, endIndex), allowMalformed: true)
        .replaceAll(RegExp(r'[\x00-\x1F\x7F-\x9F\uFEFF]'), '')
        .trim();
  } catch (e) {
    return 'Error decoding data. Raw Hex: $hexString';
  }
}
