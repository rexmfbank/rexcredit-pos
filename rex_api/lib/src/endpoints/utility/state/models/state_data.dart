import 'package:equatable/equatable.dart';

class StateData extends Equatable {
  final int id;
  final String countryCode;
  final String name;
  final String? createdAt;

  const StateData({
    required this.id,
    required this.countryCode,
    required this.name,
    required this.createdAt,
  });

  const StateData.empty()
      : id = 0,
        countryCode = '',
        name = '',
        createdAt = null;

  factory StateData.fromJson(Map<String, dynamic> json) {
    return StateData(
      id: json['id'] as int,
      countryCode: json['country_code'] as String,
      name: json['name'] as String,
      createdAt: json['created_at'] as String?,
    );
  }

  @override
  String toString() => {
        "CLASS": "StateData",
        "id": id,
        "country_code": countryCode,
        "name": name,
        "created_at": createdAt,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        countryCode,
        name,
        createdAt,
      ];
}
