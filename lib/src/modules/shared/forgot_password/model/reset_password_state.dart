import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class ResetPasswordState extends Equatable {
  final TextEditingController passwordController;
  final TextEditingController otpController;
  final AsyncValue<SelfPasswordResetResponse?> apiResponse;

  const ResetPasswordState({
    required this.passwordController,
    required this.otpController,
    this.apiResponse = const AsyncValue.data(null),
  });

  ResetPasswordState copyWith({
    TextEditingController? passwordController,
    TextEditingController? otpController,
    AsyncValue<SelfPasswordResetResponse>? apiResponse,
  }) {
    return ResetPasswordState(
      passwordController: passwordController ?? this.passwordController,
      otpController: otpController ?? this.otpController,
      apiResponse: apiResponse ?? this.apiResponse,
    );
  }

  @override
  List<Object?> get props => [
        passwordController,
        otpController,
        apiResponse,
      ];
}
