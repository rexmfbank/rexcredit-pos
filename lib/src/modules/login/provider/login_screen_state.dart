import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Identifies the outcome of the last login attempt so the screen only reacts
/// once per attempt.
enum LoginEvent { none, success, failed, locationOtpRequired }

class LoginScreenState extends Equatable {
  final String? passwordValidation;
  final bool isLoading;
  final TextEditingController oneEmail;
  final TextEditingController onePasscode;
  final TextEditingController twoPhone;
  final TextEditingController twoPasscode;
  final int tabIndex;
  final String msgError;
  final String msgSuccess;
  final LoginEvent event;

  const LoginScreenState({
    required this.passwordValidation,
    required this.isLoading,
    required this.oneEmail,
    required this.onePasscode,
    required this.twoPhone,
    required this.twoPasscode,
    required this.tabIndex,
    required this.msgError,
    required this.msgSuccess,
    this.event = LoginEvent.none,
  });

  LoginScreenState copyWith({
    String? passwordValidation,
    bool? isLoading,
    TextEditingController? oneEmail,
    TextEditingController? onePasscode,
    TextEditingController? twoPhone,
    TextEditingController? twoPasscode,
    int? tabIndex,
    String? msgError,
    String? msgSuccess,
    LoginEvent? event,
  }) {
    return LoginScreenState(
      passwordValidation: passwordValidation ?? this.passwordValidation,
      isLoading: isLoading ?? this.isLoading,
      oneEmail: oneEmail ?? this.oneEmail,
      onePasscode: onePasscode ?? this.onePasscode,
      twoPhone: twoPhone ?? this.twoPhone,
      twoPasscode: twoPasscode ?? this.twoPasscode,
      tabIndex: tabIndex ?? this.tabIndex,
      msgError: msgError ?? this.msgError,
      msgSuccess: msgSuccess ?? this.msgSuccess,
      event: event ?? this.event,
    );
  }

  @override
  List<Object?> get props => [
    passwordValidation,
    isLoading,
    oneEmail,
    onePasscode,
    twoPhone,
    twoPasscode,
    tabIndex,
    msgError,
    msgSuccess,
    event,
  ];
}
