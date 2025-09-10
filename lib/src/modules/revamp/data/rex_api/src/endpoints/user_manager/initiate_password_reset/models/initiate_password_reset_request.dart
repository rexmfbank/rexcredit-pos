import 'package:equatable/equatable.dart';

class InitiatePasswordResetRequest extends Equatable {
  final String entityCode;
  final String username;

  const InitiatePasswordResetRequest({
    required this.entityCode,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "entityCode": entityCode,
        "username": username,
      };

  @override
  List<Object?> get props => [entityCode, username];
}
