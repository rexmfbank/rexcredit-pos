import 'package:equatable/equatable.dart';

class DeactivateAccountState extends Equatable {
  final bool isLoading;
  final String message;
  final bool? isSuccess;

  const DeactivateAccountState({
    required this.isLoading,
    required this.message,
    required this.isSuccess,
  });

  DeactivateAccountState copyWith({
    bool? isLoading,
    String? message,
    bool? isSuccess,
  }) {
    return DeactivateAccountState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, message, isSuccess];
}
