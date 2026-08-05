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

class ChangePasswordRequest extends Equatable {
  const ChangePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  Map<String, dynamic> toJson() => {
        "current_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      };

  @override
  List<Object?> get props =>
      [currentPassword, newPassword, newPasswordConfirmation];
}
