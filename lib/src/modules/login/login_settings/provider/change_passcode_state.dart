import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ChangePasscodeEvent {
  none,
  success,
  failed,
}

class ChangePasscodeState extends Equatable {
  final bool isLoading;
  final TextEditingController currentPasscode;
  final TextEditingController newPasscode;
  final TextEditingController confirmPasscode;
  final String msgError;
  final String msgSuccess;
  final ChangePasscodeEvent event;

  const ChangePasscodeState({
    required this.isLoading,
    required this.currentPasscode,
    required this.newPasscode,
    required this.confirmPasscode,
    required this.msgError,
    required this.msgSuccess,
    required this.event,
  });

  ChangePasscodeState copyWith({
    bool? isLoading,
    TextEditingController? currentPasscode,
    TextEditingController? newPasscode,
    TextEditingController? confirmPasscode,
    String? msgError,
    String? msgSuccess,
    ChangePasscodeEvent? event,
  }) {
    return ChangePasscodeState(
      isLoading: isLoading ?? this.isLoading,
      currentPasscode: currentPasscode ?? this.currentPasscode,
      newPasscode: newPasscode ?? this.newPasscode,
      confirmPasscode: confirmPasscode ?? this.confirmPasscode,
      msgError: msgError ?? this.msgError,
      msgSuccess: msgSuccess ?? this.msgSuccess,
      event: event ?? this.event,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        currentPasscode,
        newPasscode,
        confirmPasscode,
        msgError,
        msgSuccess,
        event,
      ];
}
