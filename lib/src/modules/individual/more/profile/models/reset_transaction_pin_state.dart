import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';

class ResetTransactionPinOtpState extends Equatable {
  final TextEditingController pinController;
  final TextEditingController otpController;
  final AsyncValue<InitiatePasswordResetResponse?> initiateResetResponse;
  final AsyncValue<ResetTransactionPinResponse?> resetResponse;

  const ResetTransactionPinOtpState(
      {required this.pinController,
      required this.otpController,
      this.initiateResetResponse = const AsyncValue.data(null),
      this.resetResponse = const AsyncValue.data(null)});

  ResetTransactionPinOtpState copyWith(
      {TextEditingController? pinController,
      TextEditingController? otpController,
      AsyncValue<InitiatePasswordResetResponse>? initiateResponse,
      AsyncValue<ResetTransactionPinResponse>? resetResponse}) {
    return ResetTransactionPinOtpState(
        pinController: pinController ?? this.pinController,
        otpController: otpController ?? this.otpController,
        initiateResetResponse: initiateResponse ?? initiateResetResponse,
        resetResponse: resetResponse ?? this.resetResponse);
  }

  @override
  List<Object?> get props =>
      [pinController, otpController, initiateResetResponse, resetResponse];
}
