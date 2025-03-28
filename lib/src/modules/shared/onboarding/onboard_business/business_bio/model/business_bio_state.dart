import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/models/state_lga_response.dart';

class BusinessBioState extends Equatable {
  final TextEditingController businessNameController;
  final TextEditingController businessEmailController;
  final TextEditingController businessRegNumberController;
  final TextEditingController businessTaxController;
  final TextEditingController businessAddressController;
  final TextEditingController businessPhoneController;
  final TextEditingController businessYearsController;
  final String businessType;
  final String businessRegistered;
  final String businessRegistrationLink;
  final String businessState;
  final String businessLGA;
  final String businessSector;
  final String businessLogo;
  final List<LGAsResponse>? stateLgaResponse;
  final List<BusinessDirectorInfo> directors;

  const BusinessBioState({
    required this.businessNameController,
    required this.businessEmailController,
    required this.businessRegNumberController,
    required this.businessTaxController,
    required this.businessAddressController,
    required this.businessPhoneController,
    required this.businessYearsController,
    required this.businessType,
    required this.businessRegistered,
    required this.businessRegistrationLink,
    required this.businessSector,
    required this.businessLogo,
    required this.businessState,
    required this.businessLGA,
    required this.stateLgaResponse,
    this.directors = const [],
  });

  BusinessBioState copyWith({
    TextEditingController? businessNameController,
    TextEditingController? businessEmailController,
    TextEditingController? businessRegNumberController,
    TextEditingController? businessTaxController,
    TextEditingController? businessAddressController,
    TextEditingController? businessPhoneController,
    TextEditingController? businessYearsController,
    String? businessType,
    String? businessRegistered,
    String? businessRegistrationLink,
    String? businessSector,
    String? businessLogo,
    String? businessState,
    String? businessLGA,
    List<LGAsResponse>? stateLgaResponse,
    List<BusinessDirectorInfo>? directors,
  }) {
    return BusinessBioState(
      businessNameController:
          businessNameController ?? this.businessNameController,
      businessEmailController:
          businessEmailController ?? this.businessEmailController,
      businessRegNumberController:
          businessRegNumberController ?? this.businessRegNumberController,
      businessTaxController:
          businessTaxController ?? this.businessTaxController,
      businessAddressController:
          businessAddressController ?? this.businessAddressController,
      businessPhoneController:
          businessPhoneController ?? this.businessPhoneController,
      businessYearsController:
          businessYearsController ?? this.businessYearsController,
      businessType: businessType ?? this.businessType,
      businessRegistered: businessRegistered ?? this.businessRegistered,
      businessRegistrationLink:
          businessRegistrationLink ?? this.businessRegistrationLink,
      businessState: businessState ?? this.businessState,
      businessLGA: businessLGA ?? this.businessLGA,
      businessSector: businessSector ?? this.businessSector,
      businessLogo: businessLogo ?? this.businessLogo,
      stateLgaResponse: stateLgaResponse ?? this.stateLgaResponse,
      directors: directors ?? this.directors,
    );
  }

  @override
  List<Object?> get props => [
        businessNameController.text,
        businessEmailController.text,
        businessRegNumberController.text,
        businessTaxController.text,
        businessAddressController.text,
        businessPhoneController.text,
        businessYearsController.text,
        businessType,
        businessRegistered,
        businessRegistrationLink,
        businessSector,
        businessLogo,
        businessState,
        businessLGA,
      ];

  Map<String, dynamic> toJson() => {
        "businessNameController": businessNameController.text,
        "businessEmailController": businessEmailController.text,
        "businessRegNumberController": businessRegNumberController.text,
        "businessTaxController": businessTaxController.text,
        "businessAddressController": businessAddressController.text,
        "businessPhoneController": businessPhoneController.text,
        "businessYearsController": businessYearsController.text,
        "businessType": businessType,
        "businessRegistered": businessRegistered,
        "businessRegistrationLink": businessRegistrationLink,
        "businessSector": businessSector,
        "businessLogo": businessLogo,
        "businessState": businessState,
        "businessLGA": businessLGA,
        "directors": directors,
      };

  @override
  String toString() => "BusinessBioState ${toJson()}";
}
