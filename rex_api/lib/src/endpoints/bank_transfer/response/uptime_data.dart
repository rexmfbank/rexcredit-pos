import 'package:equatable/equatable.dart';

class UptimeData extends Equatable {
  final String bankName;
  final num uptimePercent;

  const UptimeData({
    required this.bankName,
    required this.uptimePercent,
  });

  const UptimeData.empty()
      : bankName = '',
        uptimePercent = 0;

  factory UptimeData.fromJson(Map<String, dynamic> json) {
    return UptimeData(
      bankName: json['bankName'] as String,
      uptimePercent: json['uptimePercent'] as num,
    );
  }

  @override
  String toString() => {
        "CLASS": "UptimeData",
        "bankName": bankName,
        "uptimePercent": uptimePercent
      }.toString();

  @override
  List<Object?> get props => [bankName, uptimePercent];
}
