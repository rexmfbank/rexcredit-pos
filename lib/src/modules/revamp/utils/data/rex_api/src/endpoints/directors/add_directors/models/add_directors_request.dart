import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class AddDirectorsRequest extends Equatable {
  final String businessCode;
  final List<AddDirectorsRequestData> directors;

  AddDirectorsRequest({required this.businessCode, required this.directors});

  Map<String, dynamic> toJson() {
    return {
      'businessCode': businessCode,
      'directors': directors,
    };
  }

  @override
  List<Object?> get props => [businessCode, directors];
}
