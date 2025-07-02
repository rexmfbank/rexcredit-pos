import 'package:equatable/equatable.dart';

class LocalGovtData extends Equatable {
  final int id;
  final int stateId;
  final String name;
  final String? createdAt;

  const LocalGovtData({
    required this.id,
    required this.stateId,
    required this.name,
    required this.createdAt,
  });

  const LocalGovtData.empty()
      : id = 0,
        stateId = 0,
        name = '',
        createdAt = null;

  factory LocalGovtData.fromJson(Map<String, dynamic> json) {
    return LocalGovtData(
      id: json['id'] as int,
      stateId: json['state_id'] as int,
      name: json['name'] as String,
      createdAt: json['created_at'] as String?,
    );
  }

  @override
  String toString() => {
        "CLASS": "LocalGovtData",
        "id": id,
        "state_id": stateId,
        "name": name,
        "created_at": createdAt,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        stateId,
        name,
        createdAt,
      ];
}
