import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TransactionDisputeState extends Equatable {
  final TextEditingController textController;

  const TransactionDisputeState({
    required this.textController,
  });

  @override
  List<Object?> get props => [textController];
}
