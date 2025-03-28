import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AddDirectorFormState extends Equatable {
  final TextEditingController firstNameController;
  final TextEditingController middleNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController mobileNoController;
  final TextEditingController sharesController;
  final TextEditingController bvnController;
  final TextEditingController addressController;
  final TextEditingController dobController;
  final DateTime? dateOfBirth;
  final String gender;
  final GlobalKey<FormState> formKey;

  const AddDirectorFormState(
      {required this.firstNameController,
      required this.middleNameController,
      required this.lastNameController,
      required this.emailController,
      required this.mobileNoController,
      required this.sharesController,
      required this.bvnController,
      required this.addressController,
      required this.dobController,
      required this.dateOfBirth,
      required this.gender,
      required this.formKey});

  AddDirectorFormState copyWith({
    TextEditingController? firstNameController,
    TextEditingController? middleNameController,
    TextEditingController? lastNameController,
    TextEditingController? emailController,
    TextEditingController? mobileNoController,
    TextEditingController? sharesController,
    TextEditingController? bvnController,
    TextEditingController? addressController,
    TextEditingController? dobController,
    DateTime? dateOfBirth,
    String? gender,
    GlobalKey<FormState>? formKey,
  }) {
    return AddDirectorFormState(
        firstNameController: firstNameController ?? this.firstNameController,
        middleNameController: middleNameController ?? this.middleNameController,
        lastNameController: lastNameController ?? this.lastNameController,
        emailController: emailController ?? this.emailController,
        mobileNoController: mobileNoController ?? this.mobileNoController,
        sharesController: sharesController ?? this.sharesController,
        bvnController: bvnController ?? this.bvnController,
        addressController: addressController ?? this.addressController,
        dobController: dobController ?? this.dobController,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        formKey: formKey ?? this.formKey);
  }

  @override
  List<Object?> get props => [
        firstNameController,
        middleNameController,
        lastNameController,
        emailController,
        mobileNoController,
        sharesController,
        bvnController,
        addressController,
        dobController,
        dateOfBirth,
        gender,
      ];
}
