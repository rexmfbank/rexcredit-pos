import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';

class LoginScreenState extends Equatable {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final String? passwordValidation;
  final bool canAuthenticate;
  final AsyncValue<LoginResponse?> loginResponse;
  final bool isLoading;

  const LoginScreenState({
    required this.usernameController,
    required this.passwordController,
    this.passwordValidation,
    this.canAuthenticate = false,
    this.loginResponse = const AsyncValue.data(null),
    required this.isLoading,
  });

  LoginScreenState copyWith({
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    String? passwordValidation,
    bool? canAuthenticate,
    AsyncValue<LoginResponse>? loginResponse,
    bool? isLoading,
  }) {
    return LoginScreenState(
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      passwordValidation: passwordValidation ?? this.passwordValidation,
      loginResponse: loginResponse ?? this.loginResponse,
      canAuthenticate: canAuthenticate ?? this.canAuthenticate,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() => {
        "CLASS": "LoginScreenState",
        "username": usernameController.text,
        "password": passwordController.text,
        "loginResponse": loginResponse,
      }.toString();

  @override
  List<Object?> get props => [
        usernameController,
        passwordController,
        loginResponse,
        isLoading,
      ];
}
