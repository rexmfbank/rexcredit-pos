import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class TransDisputeState extends Equatable {
  final bool isLoading;
  final TextEditingController textController;

  const TransDisputeState({
    required this.isLoading,
    required this.textController,
  });

  TransDisputeState copyWith({
    bool? isLoading,
    TextEditingController? textController,
  }) {
    return TransDisputeState(
      isLoading: isLoading ?? this.isLoading,
      textController: textController ?? this.textController,
    );
  }

  @override
  List<Object?> get props => [isLoading, textController];
}
