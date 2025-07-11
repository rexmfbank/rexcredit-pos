import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChangePasswordState extends Equatable {
  final TextEditingController currentPassController;
  final TextEditingController newPassController;
  final TextEditingController confirmPassController;
  final bool isLoading;
  final String newPassField;

  const ChangePasswordState({
    required this.currentPassController,
    required this.newPassController,
    required this.confirmPassController,
    required this.isLoading,
    required this.newPassField,
  });

  ChangePasswordState copyWith({
    TextEditingController? currentPassController,
    TextEditingController? newPassController,
    TextEditingController? confirmPassController,
    bool? isLoading,
    String? newPassField,
  }) {
    return ChangePasswordState(
      currentPassController:
          currentPassController ?? this.currentPassController,
      newPassController: newPassController ?? this.newPassController,
      confirmPassController:
          confirmPassController ?? this.confirmPassController,
      isLoading: isLoading ?? this.isLoading,
      newPassField: newPassField ?? this.newPassField,
    );
  }

  @override
  List<Object?> get props => [
        currentPassController,
        newPassController,
        confirmPassController,
        isLoading,
        newPassField,
      ];
}
