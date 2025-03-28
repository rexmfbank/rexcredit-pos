import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/model/account_type_enum.dart';

class SelectAccountTypeState extends Equatable {
  final AccountType? accountType;

  const SelectAccountTypeState({
    required this.accountType,
  });

  SelectAccountTypeState copyWith({
    AccountType? accountType,
  }) {
    return SelectAccountTypeState(
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  List<Object?> get props => [accountType];
}
