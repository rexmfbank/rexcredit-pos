import 'package:equatable/equatable.dart';

class EncryptCheck extends Equatable {
  const EncryptCheck({required this.payloadEncryption});

  final bool? payloadEncryption;

  factory EncryptCheck.fromJson(Map<String, dynamic> json) {
    return EncryptCheck(payloadEncryption: json["payload_encryption"]);
  }

  Map<String, dynamic> toJson() => {"payload_encryption": payloadEncryption};

  @override
  List<Object?> get props => [payloadEncryption];
}
