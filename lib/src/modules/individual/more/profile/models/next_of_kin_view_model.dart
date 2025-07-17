import 'package:flutter/material.dart';

class NextOfKinViewModel {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController addressController;
  final TextEditingController phoneController;
  final DateTime? dateOfBirth;
  final GlobalKey<FormState> formKey;
  final String? kinRelationship;

  NextOfKinViewModel({
    required this.firstNameController,
    required this.lastNameController,
    required this.addressController,
    required this.phoneController,
    required this.dateOfBirth,
    required this.formKey,
    required this.kinRelationship,
  });

  NextOfKinViewModel copyWith({
    TextEditingController? firstNameController,
    TextEditingController? lastNameController,
    TextEditingController? addressController,
    TextEditingController? phoneController,
    TextEditingController? dobController,
    DateTime? dateOfBirth,
    GlobalKey<FormState>? formKey,
    String? kinRelationship,
  }) {
    return NextOfKinViewModel(
      firstNameController: firstNameController ?? this.firstNameController,
      lastNameController: lastNameController ?? this.lastNameController,
      addressController: addressController ?? this.addressController,
      phoneController: phoneController ?? this.phoneController,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      formKey: formKey ?? this.formKey,
      kinRelationship: kinRelationship ?? this.kinRelationship,
    );
  }
}
