import 'package:equatable/equatable.dart';

class PosGlobalState extends Equatable {
  final bool hasBaseAppName;
  final bool isLoading;
  final bool canPrint;
  final String message;

  const PosGlobalState({
    required this.hasBaseAppName,
    required this.isLoading,
    required this.canPrint,
    required this.message,
  });

  PosGlobalState copyWith({
    bool? hasBaseAppName,
    bool? isLoading,
    bool? canPrint,
    String? message,
  }) {
    return PosGlobalState(
      hasBaseAppName: hasBaseAppName ?? this.hasBaseAppName,
      isLoading: isLoading ?? this.isLoading,
      canPrint: canPrint ?? this.canPrint,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [hasBaseAppName, isLoading, canPrint, message];
}
