import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class OtpScreenState extends Equatable {
  final TextEditingController otpController;

  const OtpScreenState({
    required this.otpController,
  });

  OtpScreenState copyWith({
    TextEditingController? otpController,
  }) {
    return OtpScreenState(
      otpController: otpController ?? this.otpController,
    );
  }

  @override
  String toString() => {
        "CLASS": "OtpScreenState",
        "otpController": otpController,
      }.toString();

  @override
  List<Object?> get props => [otpController];
}
