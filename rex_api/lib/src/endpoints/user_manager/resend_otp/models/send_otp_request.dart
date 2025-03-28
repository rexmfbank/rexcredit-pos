import 'package:equatable/equatable.dart';

class SendOtpRequest extends Equatable {
  final String? actionCode;
  final String username;

  const SendOtpRequest({
    this.actionCode,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "actionCode": actionCode ?? '',
        "username": username,
      };

  @override
  List<Object?> get props => [actionCode, username];
}
