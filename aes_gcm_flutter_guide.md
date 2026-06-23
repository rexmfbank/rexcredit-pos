# AES-256-GCM Payload Encryption — Flutter Implementation Guide

## How It Works (The Contract)

Every request body is encrypted before sending, and every response body is decrypted after receiving.
The encryption format is a single Base64 string with this exact byte layout:

```
[ IV (12 bytes) ][ Ciphertext (n bytes) ][ Auth Tag (16 bytes) ]
```

This combined blob is Base64-encoded and sent/received as:
```json
{ "enc": "<base64string>" }
```

The key is a **32-byte AES-256 key**, shared between the server and the mobile app,
represented as a **64-character hex string**.

---

## Setup

Add `pointycastle` to your `pubspec.yaml`:

```yaml
dependencies:
  pointycastle: ^3.9.1
```

---

## Step 1 — Encryption Utility (`lib/utils/crypto_utils.dart`)

```dart
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class CryptoUtils {
  /// The shared 32-byte key as a hex string (64 characters).
  /// Store this securely — e.g. via flutter_secure_storage or obfuscated env config.
  static const String _hexKey = 'YOUR_64_CHAR_HEX_KEY_HERE';

  static Uint8List _hexToBytes(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (int i = 0; i < hex.length; i += 2) {
      result[i ~/ 2] = int.parse(hex.substring(i, i + 2), radix: 16);
    }
    return result;
  }

  static Uint8List _generateIV() {
    final random = SecureRandom('Fortuna')
      ..seed(KeyParameter(
        Uint8List.fromList(
          List.generate(32, (_) => Random.secure().nextInt(256)),
        ),
      ));
    return random.nextBytes(12); // 12-byte IV for GCM
  }

  /// Encrypts a JSON map and returns the Base64-encoded payload.
  /// Send this as: { "enc": "<result>" }
  static String encryptPayload(Map<String, dynamic> body) {
    final keyBytes = _hexToBytes(_hexKey);
    final iv = _generateIV();
    final plaintext = Uint8List.fromList(utf8.encode(jsonEncode(body)));

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
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
    final ciphertextWithTag = combined.sublist(12); // ciphertext + tag (16 bytes at end)

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
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
```

---

## Step 2 — Dio Interceptor (`lib/interceptors/encryption_interceptor.dart`)

This is the key piece — add it once and **every endpoint is automatically encrypted/decrypted**.
You never need to touch individual API calls.

```dart
import 'package:dio/dio.dart';
import '../utils/crypto_utils.dart';

class EncryptionInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Only encrypt if there is a JSON body map
    if (options.data != null && options.data is Map<String, dynamic>) {
      final encrypted = CryptoUtils.encryptPayload(options.data);
      options.data = {'enc': encrypted};
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Only decrypt if the response contains an "enc" field
    if (response.data != null &&
        response.data is Map &&
        response.data['enc'] != null) {
      final decrypted = CryptoUtils.decryptResponse(response.data['enc']);
      response.data = decrypted;
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, DioErrorInterceptorHandler handler) {
    // Also try to decrypt error response bodies
    if (err.response?.data != null &&
        err.response!.data is Map &&
        err.response!.data['enc'] != null) {
      try {
        final decrypted = CryptoUtils.decryptResponse(err.response!.data['enc']);
        err.response!.data = decrypted;
      } catch (_) {
        // If decryption fails on error body, leave it as-is
      }
    }
    handler.next(err);
  }
}
```

---

## Step 3 — Register the Interceptor (`lib/core/dio_client.dart`)

Do this **once** at app startup or in your DI setup:

```dart
import 'package:dio/dio.dart';
import '../interceptors/encryption_interceptor.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'https://your-api-base-url.com',
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);

// Register the encryption interceptor — handles all requests/responses
dio.interceptors.add(EncryptionInterceptor());
```

---

## Step 4 — Using It (No Changes Per Endpoint)

After setup, every API call works exactly as normal. No encryption code needed at the call site:

```dart
// Login
final response = await dio.post('/customer/login', data: {
  'phone': '08029400857',
  'password': '123456#',
});
// response.data is already the decrypted JSON map
final token = response.data['token'];

// Any other endpoint — same pattern
final profileResponse = await dio.get('/customer/profile');
final profile = profileResponse.data; // already decrypted
```

---

## Wire Format Reference

| Component     | Size      | Position in combined bytes        |
|---------------|-----------|-----------------------------------|
| IV            | 12 bytes  | bytes 0–11                        |
| Ciphertext    | n bytes   | bytes 12 to (total - 17)          |
| Auth Tag      | 16 bytes  | last 16 bytes                     |
| **Combined**  | 12+n+16   | Base64-encoded, sent as `"enc"`   |

---

## Key Storage (Important)

Never hardcode the key in plain text in production. Options:

1. **`flutter_secure_storage`** — store the key in the device's secure keychain/keystore
2. **Remote config with certificate pinning** — fetch the key from a secure bootstrap endpoint
3. **Obfuscated build config** — use `--dart-define` with Flutter build flavors (least secure)

```yaml
# pubspec.yaml — recommended secure storage package
dependencies:
  flutter_secure_storage: ^9.0.0
```

```dart
// Storing the key securely
const storage = FlutterSecureStorage();
await storage.write(key: 'PAYLOAD_ENCRYPTION_KEY', value: hexKey);

// Reading it back
final hexKey = await storage.read(key: 'PAYLOAD_ENCRYPTION_KEY');
```

---

## Security Notes

- **IV is random per request** — never reuse an IV with the same key. The implementation above generates a fresh 12-byte IV for every encryption call.
- **Auth tag verification** — `pointycastle` automatically verifies the 16-byte GCM auth tag on decryption. If the data was tampered with, it throws an exception. Catch this and treat it as a security violation.
- **Key rotation** — if the server rotates the key, update it in secure storage without a full app release.
