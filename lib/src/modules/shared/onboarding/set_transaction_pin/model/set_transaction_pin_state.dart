import 'package:equatable/equatable.dart';

class SetTransactionPinState extends Equatable {
  final String pin;
  final String confirmPin;
  final bool fromSignUp;
  final Object? error;

  const SetTransactionPinState({
    required this.pin,
    required this.confirmPin,
    this.fromSignUp = false,
    this.error,
  });

  SetTransactionPinState copyWith({
    String? pin,
    String? confirmPin,
    bool? fromSignUp,
    Object? error,
  }) {
    return SetTransactionPinState(
      pin: pin ?? this.pin,
      confirmPin: confirmPin ?? this.confirmPin,
      fromSignUp: fromSignUp ?? this.fromSignUp,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => {
        "CLASS": "SetTransactionPinResponse",
        "pin": pin,
        "confirmPin": confirmPin,
        "error": error,
        "fromSignUp": fromSignUp,
      }.toString();

  @override
  List<Object?> get props => [
        pin,
        confirmPin,
        error,
        fromSignUp,
      ];
}
