import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Identifies which request produced the current message so each screen only
/// reacts to its own outcome.
enum ForgotPasswordEvent {
  none,
  otpSent,
  otpSendFailed,
  otpResent,
  otpResendFailed,
  passcodeReset,
  passcodeResetFailed,
}

class ForgotPasswordState extends Equatable {
  final bool isLoading;
  final TextEditingController email;
  final TextEditingController otp;
  final TextEditingController newPasscode;
  final TextEditingController confirmPasscode;

  /// Seconds left before the OTP can be requested again. Zero means resend
  /// is available.
  final int resendCountdown;

  final String msgError;
  final String msgSuccess;
  final ForgotPasswordEvent event;

  const ForgotPasswordState({
    required this.isLoading,
    required this.email,
    required this.otp,
    required this.newPasscode,
    required this.confirmPasscode,
    required this.resendCountdown,
    required this.msgError,
    required this.msgSuccess,
    required this.event,
  });

  bool get canResendOtp => resendCountdown == 0;

  ForgotPasswordState copyWith({
    bool? isLoading,
    TextEditingController? email,
    TextEditingController? otp,
    TextEditingController? newPasscode,
    TextEditingController? confirmPasscode,
    int? resendCountdown,
    String? msgError,
    String? msgSuccess,
    ForgotPasswordEvent? event,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPasscode: newPasscode ?? this.newPasscode,
      confirmPasscode: confirmPasscode ?? this.confirmPasscode,
      resendCountdown: resendCountdown ?? this.resendCountdown,
      msgError: msgError ?? this.msgError,
      msgSuccess: msgSuccess ?? this.msgSuccess,
      event: event ?? this.event,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        email,
        otp,
        newPasscode,
        confirmPasscode,
        resendCountdown,
        msgError,
        msgSuccess,
        event,
      ];
}
