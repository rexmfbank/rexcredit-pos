import 'package:equatable/equatable.dart';

class CreateDisputeRequest extends Equatable {
  final String transactionId;
  final String username;
  final String disputeMessage;

  const CreateDisputeRequest({
    required this.transactionId,
    required this.username,
    required this.disputeMessage,
  });

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "username": username,
        "disputeMessage": disputeMessage,
      };

  @override
  List<Object?> get props => [
        transactionId,
        username,
        disputeMessage,
      ];
}
