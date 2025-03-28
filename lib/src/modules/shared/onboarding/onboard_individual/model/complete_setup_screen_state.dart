import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class CompleteSetupScreenState extends Equatable {
  final TextEditingController addressController;
  final String gender;
  final String customerType;
  final TextEditingController referralCodeController;
  final String language;
  final String state;
  final String lga;
  final List<LGAsResponse>? stateLgaResponse;
  final bool isLoading;

  const CompleteSetupScreenState({
    required this.addressController,
    required this.gender,
    required this.customerType,
    required this.referralCodeController,
    required this.language,
    required this.state,
    required this.lga,
    required this.stateLgaResponse,
    this.isLoading = false,
  });

  CompleteSetupScreenState copyWith({
    TextEditingController? addressController,
    String? gender,
    String? customerType,
    TextEditingController? referralCodeController,
    String? language,
    String? state,
    String? lga,
    List<LGAsResponse>? stateLgaResponse,
    bool? isLoading,
  }) {
    return CompleteSetupScreenState(
      isLoading: isLoading ?? this.isLoading,
      addressController: addressController ?? this.addressController,
      gender: gender ?? this.gender,
      customerType: customerType ?? this.customerType,
      referralCodeController:
          referralCodeController ?? this.referralCodeController,
      language: language ?? this.language,
      state: state ?? this.state,
      lga: lga ?? this.lga,
      stateLgaResponse: stateLgaResponse ?? this.stateLgaResponse,
    );
  }

  @override
  List<Object?> get props => [
        addressController,
        gender,
        customerType,
        referralCodeController,
        language,
        state,
        lga,
      ];
}
