import 'package:equatable/equatable.dart';

class StateApiResponse extends Equatable {
  final String status;
  final String message;
  final List<StateNG> data;

  const StateApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  const StateApiResponse.empty()
      : status = '',
        message = '',
        data = const [];

  factory StateApiResponse.fromJson(Map<String, dynamic> json) {
    return StateApiResponse(
      status: json['status'],
      message: json['message'],
      data: List<StateNG>.from(
        json['data'].map((e) => StateNG.fromJson(e)),
      ),
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "StateApiResponse",
      "status": status,
      "message": message,
      "data": data,
    }.toString();
  }

  @override
  List<Object?> get props => [status, message, data];
}

class StateNG extends Equatable {
  final int id;
  final String name;

  const StateNG({
    required this.id,
    required this.name,
  });

  const StateNG.empty()
      : id = 0,
        name = '';

  factory StateNG.fromJson(Map<String, dynamic> json) {
    return StateNG(
      id: json['id'],
      name: json['name'],
    );
  }

  StateNG copyWith({
    int? id,
    String? name,
  }) {
    return StateNG(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "StateNG",
      "id": id,
      "name": name,
    }.toString();
  }

  @override
  List<Object?> get props => [id, name];
}
