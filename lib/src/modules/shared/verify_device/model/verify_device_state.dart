import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class VerifyDeviceState extends Equatable {
  final TextEditingController otpController;

  const VerifyDeviceState({
    required this.otpController,
  });

  VerifyDeviceState copyWith({
    TextEditingController? otpController,
  }) {
    return VerifyDeviceState(
      otpController: otpController ?? this.otpController,
    );
  }

  @override
  List<Object?> get props => [otpController];
}
