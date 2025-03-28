import 'package:equatable/equatable.dart';

class EncodeImageResponse extends Equatable {
  final String base;

  const EncodeImageResponse({required this.base});

  @override
  List<Object?> get props => [base];

  factory EncodeImageResponse.fromJson(Map<String, dynamic> json) {
    return EncodeImageResponse(
      base: json['base'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'base': base,
    };
  }
}
