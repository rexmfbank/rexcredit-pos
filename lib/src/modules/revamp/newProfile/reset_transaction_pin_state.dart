import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';


class ResetTransactionPinOtpState extends Equatable {
  final TextEditingController pinController;
  final TextEditingController otpController;
  final bool isLoading;

  const ResetTransactionPinOtpState({
    required this.pinController,
    required this.otpController,
    required this.isLoading,
  });

  ResetTransactionPinOtpState copyWith({
    TextEditingController? pinController,
    TextEditingController? otpController,
    bool? isLoading,
  }) {
    return ResetTransactionPinOtpState(
      pinController: pinController ?? this.pinController,
      otpController: otpController ?? this.otpController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        pinController,
        otpController,
        isLoading,
      ];
}
