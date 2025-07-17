import 'package:flutter/material.dart';

class PersonalInfoViewModel {
  final TextEditingController middleNameController;
  final GlobalKey<FormState> formKey;

  PersonalInfoViewModel({
    required this.middleNameController,
    required this.formKey,
  });

  PersonalInfoViewModel copyWith({
    TextEditingController? middleNameController,
    GlobalKey<FormState>? formKey,
    String? kinRelationship,
  }) {
    return PersonalInfoViewModel(
      middleNameController: middleNameController ?? this.middleNameController,
      formKey: formKey ?? this.formKey,
    );
  }
}
