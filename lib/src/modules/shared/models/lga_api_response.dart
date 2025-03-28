import 'package:equatable/equatable.dart';

class LgaApiResponse extends Equatable {
  final String status;
  final String message;
  final List<LgaNG> data;

  const LgaApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  const LgaApiResponse.empty()
      : status = '',
        message = '',
        data = const [];

  factory LgaApiResponse.fromJson(Map<String, dynamic> json) {
    return LgaApiResponse(
      status: json['status'],
      message: json['message'],
      data: List<LgaNG>.from(
        json['data'].map((e) => LgaNG.fromJson(e)),
      ),
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "LgaApiResponse",
      "status": status,
      "message": message,
      "data": data,
    }.toString();
  }

  @override
  List<Object?> get props => [status, message, data];
}

class LgaNG extends Equatable {
  final int id;
  final String localName;
  final String state;

  const LgaNG({
    required this.id,
    required this.localName,
    required this.state,
  });

  const LgaNG.empty()
      : id = 0,
        localName = '',
        state = '';

  factory LgaNG.fromJson(Map<String, dynamic> json) {
    return LgaNG(
      id: json['id'],
      localName: json['local_name'],
      state: json['state'],
    );
  }

  @override
  String toString() {
    return {
      "CLASS": "LgaNG",
      "id": id,
      "localName": localName,
      "state": state,
    }.toString();
  }

  @override
  List<Object?> get props => [
        id,
        localName,
        state,
      ];
}

class LgaForm extends Equatable {
  final String stateName;
  final String authToken;

  const LgaForm({
    required this.stateName,
    required this.authToken,
  });

  const LgaForm.empty()
      : stateName = '',
        authToken = '';

  @override
  String toString() {
    return {
      "CLASS": "LgaForm",
      "stateName": stateName,
      "authToken": authToken,
    }.toString();
  }

  @override
  List<Object?> get props => [stateName, authToken];
}
