import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LoginScreenState extends Equatable {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? passwordValidation;
  final bool isLoading;

  const LoginScreenState({
    required this.emailController,
    required this.passwordController,
    required this.passwordValidation,
    required this.isLoading,
  });

  LoginScreenState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? passwordValidation,
    bool? isLoading,
  }) {
    return LoginScreenState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      passwordValidation: passwordValidation ?? this.passwordValidation,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
    emailController,
    passwordController,
    passwordValidation,
    isLoading,
  ];
}
