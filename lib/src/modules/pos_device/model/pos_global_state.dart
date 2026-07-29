import 'package:equatable/equatable.dart';

class PosGlobalState extends Equatable {
  final bool hasBaseAppName;
  final bool isLoading;
  final bool canPrint;

  const PosGlobalState({
    required this.hasBaseAppName,
    required this.isLoading,
    required this.canPrint,
  });

  PosGlobalState copyWith({
    bool? hasBaseAppName,
    bool? isLoading,
    bool? canPrint,
  }) {
    return PosGlobalState(
      hasBaseAppName: hasBaseAppName ?? this.hasBaseAppName,
      isLoading: isLoading ?? this.isLoading,
      canPrint: canPrint ?? this.canPrint,
    );
  }

  @override
  List<Object?> get props => [hasBaseAppName, isLoading, canPrint];
}
