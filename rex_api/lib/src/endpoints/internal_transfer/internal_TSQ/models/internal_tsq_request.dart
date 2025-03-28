import 'package:equatable/equatable.dart';

class InternalTSQRequest extends Equatable {
  final String bankCode;
  final String reference;

  const InternalTSQRequest({
    required this.bankCode,
    required this.reference,
  });

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "reference": reference,
      };

  @override
  List<Object?> get props => [
        bankCode,
        reference,
      ];
}
