import 'package:flutter/material.dart';

class BusinessRepresentativeViewModel {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController middleNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController dobController;
  final DateTime? dateOfBirth;
  final GlobalKey<FormState> formKey;

  BusinessRepresentativeViewModel({
    required this.firstNameController,
    required this.lastNameController,
    required this.middleNameController,
    required this.emailController,
    required this.phoneController,
    required this.dobController,
    required this.dateOfBirth,
    required this.formKey,
  });

  BusinessRepresentativeViewModel copyWith({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? middleNameController,
    TextEditingController? phoneController,
    TextEditingController? emailController,
    TextEditingController? dobController,
    DateTime? dateOfBirth,
    GlobalKey<FormState>? formKey,
  }) {
    return BusinessRepresentativeViewModel(
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      middleNameController: middleNameController ?? this.middleNameController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      dobController: dobController ?? this.dobController,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      formKey: formKey ?? this.formKey,
    );
  }
}
