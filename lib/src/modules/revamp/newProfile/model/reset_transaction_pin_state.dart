import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ResetTransactionPinOtpState extends Equatable {
  final TextEditingController pinController;
  final TextEditingController otpController;
  final TextEditingController newController;
  final bool isLoading;

  const ResetTransactionPinOtpState({
    required this.pinController,
    required this.otpController,
    required this.newController,
    required this.isLoading,
  });

  ResetTransactionPinOtpState copyWith({
    TextEditingController? pinController,
    TextEditingController? otpController,
    TextEditingController? newController,
    bool? isLoading,
  }) {
    return ResetTransactionPinOtpState(
      pinController: pinController ?? this.pinController,
      otpController: otpController ?? this.otpController,
      newController: newController ?? this.newController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [pinController, otpController, isLoading];
}
