import 'package:equatable/equatable.dart';

class FundSavingRequest extends Equatable {
  /// fundingSource can be "CARD" or "ACCOUNT"
  final String fundingScource;

  /// fundingSourceId will be the 'card ID' or the 'account number'
  final String fundingSourceId;

  final num amount;
  final String geoLocation;
  final String externalRefNo;

  const FundSavingRequest({
    required this.fundingScource,
    required this.fundingSourceId,
    required this.amount,
    required this.geoLocation,
    required this.externalRefNo,
  });

  Map<String, dynamic> toJson() => {
        "fundingSource": fundingScource,
        "fundingSourceId": fundingSourceId,
        "amount": amount,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo
      };

  @override
  String toString() => {
        "CLASS": "FundSavingRequest",
        "fundingSource": fundingScource,
        "fundingSourceId": fundingSourceId,
        "amount": amount,
        "geolocation": geoLocation,
        "externalRefNo": externalRefNo
      }.toString();

  @override
  List<Object?> get props => [
        fundingScource,
        fundingSourceId,
        amount,
        geoLocation,
        externalRefNo,
      ];
}
