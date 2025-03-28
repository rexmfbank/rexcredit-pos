import 'package:equatable/equatable.dart';

class UtilityProviderForm extends Equatable {
  final String authToken;
  final String typeName;

  const UtilityProviderForm({
    required this.authToken,
    required this.typeName,
  });

  const UtilityProviderForm.empty()
      : authToken = '',
        typeName = '';

  @override
  String toString() {
    return {
      "CLASS": "UtilityProviderForm",
      "authToken": authToken,
      "typeName": typeName,
    }.toString();
  }

  @override
  List<Object?> get props => [authToken, typeName];
}
