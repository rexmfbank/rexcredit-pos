import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import '../../../shared/models/state_lga_response.dart';

class UpdateResidentialAddressScreenState {
  final TextEditingController houseNumberController;
  final TextEditingController streetController;
  final TextEditingController areaController;
  final TextEditingController addressController;
  final TextEditingController stateController;
  final TextEditingController lgaController;
  final File? fileFromDevice;
  final String? fileName;
  final List<LGAsResponse> nigeriaStates;
  final List<LGAsResponse> stateLgas;
  final String selectedNigeriaState;
  final String selectedLga;
  final UpdateAddressResponse? updateAddressResponse;
  final bool isLoading;
  final String? error;
  final bool? imagesPickedHaveDownloadUrl;

  const UpdateResidentialAddressScreenState({
    required this.houseNumberController,
    required this.streetController,
    required this.areaController,
    required this.addressController,
    required this.stateController,
    required this.lgaController,
    this.fileFromDevice,
    this.fileName,
    required this.nigeriaStates,
    required this.stateLgas,
    required this.selectedNigeriaState,
    required this.selectedLga,
    this.updateAddressResponse,
    required this.isLoading,
    this.error,
    this.imagesPickedHaveDownloadUrl,
  });

  UpdateResidentialAddressScreenState copyWith({
    TextEditingController? houseNumberController,
    TextEditingController? streetController,
    TextEditingController? areaController,
    TextEditingController? addressController,
    TextEditingController? stateController,
    TextEditingController? lgaController,
    File? fileFromDevice,
    String? fileName,
    List<LGAsResponse>? nigeriaStates,
    List<LGAsResponse>? stateLgas,
    String? selectedNigeriaState,
    String? selectedLga,
    UpdateAddressResponse? updateAddressResponse,
    bool? isLoading,
    String? error,
    bool? imagesPickedHaveDownloadUrl,
  }) {
    return UpdateResidentialAddressScreenState(
      houseNumberController:
          houseNumberController ?? this.houseNumberController,
      streetController: streetController ?? this.streetController,
      areaController: areaController ?? this.areaController,
      addressController: addressController ?? this.addressController,
      stateController: stateController ?? this.stateController,
      lgaController: lgaController ?? this.lgaController,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      nigeriaStates: nigeriaStates ?? this.nigeriaStates,
      stateLgas: stateLgas ?? this.stateLgas,
      selectedNigeriaState: selectedNigeriaState ?? this.selectedNigeriaState,
      selectedLga: selectedLga ?? this.selectedLga,
      updateAddressResponse:
          updateAddressResponse ?? this.updateAddressResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imagesPickedHaveDownloadUrl:
          imagesPickedHaveDownloadUrl ?? this.imagesPickedHaveDownloadUrl,
    );
  }

  factory UpdateResidentialAddressScreenState.initial() {
    return UpdateResidentialAddressScreenState(
      houseNumberController: TextEditingController(),
      streetController: TextEditingController(),
      areaController: TextEditingController(),
      addressController: TextEditingController(),
      stateController: TextEditingController(),
      lgaController: TextEditingController(),
      nigeriaStates: [],
      stateLgas: [],
      selectedNigeriaState: '',
      selectedLga: '',
      isLoading: false,
      imagesPickedHaveDownloadUrl: false,
    );
  }
}
