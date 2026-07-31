import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Identifies the outcome of the last verification attempt so the screen only
/// reacts once per attempt.
enum VerifyLocationEvent { none, verified, failed }

class VerifyLocationState extends Equatable {
  final bool isLoading;
  final TextEditingController otp;
  final String msgError;
  final VerifyLocationEvent event;

  const VerifyLocationState({
    required this.isLoading,
    required this.otp,
    required this.msgError,
    required this.event,
  });

  VerifyLocationState copyWith({
    bool? isLoading,
    TextEditingController? otp,
    String? msgError,
    VerifyLocationEvent? event,
  }) {
    return VerifyLocationState(
      isLoading: isLoading ?? this.isLoading,
      otp: otp ?? this.otp,
      msgError: msgError ?? this.msgError,
      event: event ?? this.event,
    );
  }

  @override
  List<Object?> get props => [isLoading, otp, msgError, event];
}
