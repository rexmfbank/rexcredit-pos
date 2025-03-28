import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InitiatePasswordState extends Equatable {
  final TextEditingController nameController;

  const InitiatePasswordState({
    required this.nameController,
  });

  InitiatePasswordState copyWith({
    TextEditingController? nameController,
  }) {
    return InitiatePasswordState(
      nameController: nameController ?? this.nameController,
    );
  }

  @override
  List<Object?> get props => [nameController];
}
