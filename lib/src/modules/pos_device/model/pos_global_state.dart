import 'package:equatable/equatable.dart';

class PosGlobalState extends Equatable {
  final bool hasBaseAppName;
  final bool isLoading;
  final bool enablePrintBtn;

  const PosGlobalState({
    required this.hasBaseAppName,
    required this.isLoading,
    required this.enablePrintBtn,
  });

  PosGlobalState copyWith({
    bool? hasBaseAppName,
    bool? isLoading,
    bool? enablePrintBtn,
  }) {
    return PosGlobalState(
      hasBaseAppName: hasBaseAppName ?? this.hasBaseAppName,
      isLoading: isLoading ?? this.isLoading,
      enablePrintBtn: enablePrintBtn ?? this.enablePrintBtn,
    );
  }

  @override
  List<Object?> get props => [hasBaseAppName, isLoading, enablePrintBtn];
}
