import 'dart:io';

import 'package:equatable/equatable.dart';

class BusinessLogoState extends Equatable {
  final File? imageFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;

  const BusinessLogoState({
    this.imageFromDevice,
    this.fileName,
    required this.documentName,
    required this.documentPath,
  });

  BusinessLogoState copyWith({
    File? imageFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
  }) {
    return BusinessLogoState(
      imageFromDevice: imageFromDevice ?? this.imageFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
    );
  }

  @override
  List<Object?> get props => [
        imageFromDevice,
        fileName,
        documentName,
        documentPath,
      ];
}
