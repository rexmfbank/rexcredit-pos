import 'package:equatable/equatable.dart';

class PosGlobalState extends Equatable {
  final bool hasBaseAppName;
  final bool isLoading;

  const PosGlobalState({
    required this.hasBaseAppName,
    required this.isLoading,
  });

  PosGlobalState copyWith({
    bool? hasBaseAppName,
    bool? isLoading,
  }) {
    return PosGlobalState(
      hasBaseAppName: hasBaseAppName ?? this.hasBaseAppName,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [hasBaseAppName, isLoading];
}
