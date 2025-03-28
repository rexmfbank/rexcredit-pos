import 'package:equatable/equatable.dart';

class FetchDisputeData extends Equatable {
  final List<int>? disputedDate;
  final String? status;
  final String? transactionId;
  final String? disputeMessage;

  FetchDisputeData({
    this.disputedDate,
    this.status,
    this.transactionId,
    this.disputeMessage,
  });

  factory FetchDisputeData.fromJson(Map<String, dynamic> json) =>
      FetchDisputeData(
        disputedDate: json["disputedDate"] == null
            ? []
            : List<int>.from(json["disputedDate"].map((x) => x)),
        status: json["status"],
        transactionId: json["transactionId"],
        disputeMessage: json["disputeMessage"],
      );

  Map<String, dynamic> toJson() => {
        "disputedDate":
            disputedDate == null ? [] : disputedDate?.map((x) => x).toList(),
        "status": status,
        "transactionId": transactionId,
        "disputeMessage": disputeMessage,
      };

  @override
  List<Object?> get props => [
        disputedDate,
        status,
        transactionId,
        disputeMessage,
      ];
}
