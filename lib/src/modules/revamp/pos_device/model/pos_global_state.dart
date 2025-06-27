import 'package:equatable/equatable.dart';

class PosGlobalState extends Equatable {
  final bool hasBaseAppName;

  const PosGlobalState({
    required this.hasBaseAppName,
  });

  PosGlobalState copyWith({
    bool? hasBaseAppName,
  }) {
    return PosGlobalState(
      hasBaseAppName: hasBaseAppName ?? this.hasBaseAppName,
    );
  }

  @override
  List<Object?> get props => [hasBaseAppName];
}
