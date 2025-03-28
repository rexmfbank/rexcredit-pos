import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class RegisterScreenState extends Equatable {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController surnameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final TextEditingController bvnController;
  final TextEditingController ninController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dobController;
  final GlobalKey<FormState> formKey;
  final DateTime? dateOfBirth;
  final String onboardingId;
  final String gender;
  final bool termsAndCondition;
  final String photoLink;
  final String employmentCategory;
  final String occupation;
  final bool passwordNotMatch;
  final String annualIncomeRange;
  final bool enableSubmission;

  RegisterScreenState({
    required this.firstNameController,
    required this.middleNameController,
    required this.surnameController,
    required this.usernameController,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.bvnController,
    required this.ninController,
    required this.emailController,
    required this.phoneController,
    required this.dateOfBirth,
    required this.dobController,
    required this.formKey,
    this.photoLink = '',
    required this.employmentCategory,
    this.occupation = '',
    this.gender = '',
    this.termsAndCondition = false,
    required this.passwordNotMatch,
    required this.annualIncomeRange,
    required this.enableSubmission,
  }) : onboardingId = generateRandomString();

  RegisterScreenState copyWith({
    TextEditingController? firstNameController,
    TextEditingController? middleNameController,
    TextEditingController? surnameController,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    TextEditingController? passwordConfirmController,
    TextEditingController? bvnController,
    TextEditingController? ninController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
    TextEditingController? dobController,
    GlobalKey<FormState>? formKey,
    DateTime? dateOfBirth,
    String? onboardingId,
    String? gender,
    bool termsAndCondition = false,
    String? photoLink,
    String? employmentCategory,
    String? occupation,
    bool? isLoading,
    Object? error,
    bool? passwordNotMatch,
    String? annualIncomeRange,
    bool? enableSubmission,
  }) {
    return RegisterScreenState(
      firstNameController: firstNameController ?? this.firstNameController,
      middleNameController: middleNameController ?? this.middleNameController,
      surnameController: surnameController ?? this.surnameController,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      passwordConfirmController:
          passwordConfirmController ?? this.passwordConfirmController,
      bvnController: bvnController ?? this.bvnController,
      ninController: ninController ?? this.ninController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      dobController: dobController ?? this.dobController,
      formKey: formKey ?? this.formKey,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      termsAndCondition: termsAndCondition,
      photoLink: photoLink ?? this.photoLink,
      employmentCategory: employmentCategory ?? this.employmentCategory,
      occupation: occupation ?? this.occupation,
      passwordNotMatch: passwordNotMatch ?? this.passwordNotMatch,
      annualIncomeRange: annualIncomeRange ?? this.annualIncomeRange,
      enableSubmission: enableSubmission ?? this.enableSubmission,
    );
  }

  @override
  String toString() => {
        "CLASS": "RegisterScreenState",
        "firstNameController": firstNameController.text,
        "middleNameController": middleNameController.text,
        "surnameController": surnameController.text,
        "usernameController": usernameController.text,
        "passwordController": passwordController.text,
        "bvnController": bvnController.text,
        "ninController": ninController.text,
        "emailController": emailController.text,
        "phoneController": phoneController.text,
        "dobController": dobController.text,
        "dateOfBirth": dateOfBirth?.dateDDMMYYYY(),
        "gender": gender,
        "termsAndCondition": termsAndCondition,
        "photoLink": photoLink,
        "employmentStatus": employmentCategory,
        "occupation": occupation,
        "enableSubmission": enableSubmission,
      }.toString();

  @override
  List<Object?> get props => [
        firstNameController,
        middleNameController,
        surnameController,
        usernameController,
        passwordController,
        bvnController,
        ninController,
        emailController,
        phoneController,
        dobController,
        formKey,
        dateOfBirth,
        onboardingId,
        gender,
        termsAndCondition,
        photoLink,
        employmentCategory,
        occupation,
        annualIncomeRange,
        enableSubmission,
      ];
}
