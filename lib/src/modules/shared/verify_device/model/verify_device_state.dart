import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VerifyDeviceState extends Equatable {
  final TextEditingController otpController;
  final bool isLoading;

  const VerifyDeviceState({
    required this.otpController,
    required this.isLoading,
  });

  VerifyDeviceState copyWith({
    TextEditingController? otpController,
    bool? isLoading,
  }) {
    return VerifyDeviceState(
      otpController: otpController ?? this.otpController,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [otpController, isLoading];
}
