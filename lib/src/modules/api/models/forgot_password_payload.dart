import 'package:equatable/equatable.dart';

class SendOtpRequest extends Equatable {
  const SendOtpRequest({required this.email});

  final String email;

  Map<String, dynamic> toJson() => {"email": email};

  @override
  List<Object?> get props => [email];
}

class ResetPasswordRequest extends Equatable {
  const ResetPasswordRequest({
    required this.email,
    required this.otp,
    required this.password,
    required this.passwordConfirmation,
  });

  final String email;
  final String otp;
  final String password;
  final String passwordConfirmation;

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };

  @override
  List<Object?> get props => [email, otp, password, passwordConfirmation];
}
