import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginScreenState extends Equatable {
  final String? passwordValidation;
  final bool isLoading;
  final TextEditingController oneEmail;
  final TextEditingController onePasscode;
  final TextEditingController twoPhone;
  final TextEditingController twoPasscode;
  final int tabIndex;

  const LoginScreenState({
    required this.passwordValidation,
    required this.isLoading,
    required this.oneEmail,
    required this.onePasscode,
    required this.twoPhone,
    required this.twoPasscode,
    required this.tabIndex,
  });

  LoginScreenState copyWith({
    String? passwordValidation,
    bool? isLoading,
    TextEditingController? oneEmail,
    TextEditingController? onePasscode,
    TextEditingController? twoPhone,
    TextEditingController? twoPasscode,
    int? tabIndex,
  }) {
    return LoginScreenState(
      passwordValidation: passwordValidation ?? this.passwordValidation,
      isLoading: isLoading ?? this.isLoading,
      oneEmail: oneEmail ?? this.oneEmail,
      onePasscode: onePasscode ?? this.onePasscode,
      twoPhone: twoPhone ?? this.twoPhone,
      twoPasscode: twoPasscode ?? this.twoPasscode,
      tabIndex: tabIndex ?? this.tabIndex,
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
  ];
}
