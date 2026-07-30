import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final TextEditingController email;
  final TextEditingController otp;
  final TextEditingController newPasscode;
  final TextEditingController confirmPasscode;

  const ForgotPasswordState({
    required this.isLoading,
    required this.email,
    required this.otp,
    required this.newPasscode,
    required this.confirmPasscode,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    TextEditingController? email,
    TextEditingController? otp,
    TextEditingController? newPasscode,
    TextEditingController? confirmPasscode,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPasscode: newPasscode ?? this.newPasscode,
      confirmPasscode: confirmPasscode ?? this.confirmPasscode,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        email,
        otp,
        newPasscode,
        confirmPasscode,
      ];
}
