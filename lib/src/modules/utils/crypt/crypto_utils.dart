import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class CryptoUtils {
  static const String _hexKey =
      '1e7598a5d1f36cdeee74eafbb9592161d68fe70a38c14ce9b9dac61c00573a8f';

  static Uint8List _hexToBytes(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (int i = 0; i < hex.length; i += 2) {
      result[i ~/ 2] = int.parse(hex.substring(i, i + 2), radix: 16);
    }
    return result;
  }

  static Uint8List _generateIV() {
    final random = SecureRandom('Fortuna')..seed(
      KeyParameter(
        Uint8List.fromList(
          List.generate(32, (_) => Random.secure().nextInt(256)),
        ),
      ),
    );
    return random.nextBytes(12); // 12-byte IV for GCM
  }

  /// Encrypts a JSON map and returns the Base64-encoded payload.
  /// Send this as: { "enc": "<result>" }
  static String encryptPayload(Map<String, dynamic> body) {
    final keyBytes = _hexToBytes(_hexKey);
    final iv = _generateIV();
    final plaintext = Uint8List.fromList(utf8.encode(jsonEncode(body)));

    final cipher = GCMBlockCipher(AESEngine())..init(
      true, // true = encrypt
      AEADParameters(
        KeyParameter(keyBytes),
        128, // tag length in bits
        iv,
        Uint8List(0), // no additional authenticated data
      ),
    );

    // pointycastle appends the 16-byte tag at the end of ciphertext output
    // Output layout: ciphertext (n bytes) + tag (16 bytes)
    final ciphertextWithTag = cipher.process(plaintext);

    // Final wire format: IV (12) + ciphertext (n) + tag (16)
    final combined = Uint8List(iv.length + ciphertextWithTag.length);
    combined.setRange(0, iv.length, iv);
    combined.setRange(iv.length, combined.length, ciphertextWithTag);

    return base64Encode(combined);
  }

  /// Decrypts a Base64-encoded response string.
  /// Pass in the value of the "enc" field from the response.
  static Map<String, dynamic> decryptResponse(String encBase64) {
    final keyBytes = _hexToBytes(_hexKey);
    final combined = base64Decode(encBase64);

    // Extract parts
    final iv = combined.sublist(0, 12);
    final ciphertextWithTag = combined.sublist(
      12,
    ); // ciphertext + tag (16 bytes at end)

    final cipher = GCMBlockCipher(AESEngine())..init(
      false, // false = decrypt
      AEADParameters(
        KeyParameter(keyBytes),
        128, // tag length in bits
        iv,
        Uint8List(0), // no additional authenticated data
      ),
    );

    // pointycastle verifies the tag automatically and throws if tampered
    final decrypted = cipher.process(ciphertextWithTag);
    final plaintext = utf8.decode(decrypted);
    return jsonDecode(plaintext) as Map<String, dynamic>;
  }
}
