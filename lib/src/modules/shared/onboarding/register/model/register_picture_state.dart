import 'dart:io';

import 'package:equatable/equatable.dart';

class RegisterPictureState extends Equatable {
  final File? imageFromDevice;
  final String? fileName;
  final String documentName;
  final String documentPath;
  final bool errorUploading;

  const RegisterPictureState({
    this.imageFromDevice,
    this.fileName,
    required this.documentName,
    required this.documentPath,
    required this.errorUploading,
  });

  RegisterPictureState copyWith({
    File? imageFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
    bool? errorUploading,
  }) {
    return RegisterPictureState(
      imageFromDevice: imageFromDevice ?? this.imageFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
      errorUploading: errorUploading ?? this.errorUploading,
    );
  }

  @override
  List<Object?> get props => [
        imageFromDevice,
        fileName,
        documentName,
        documentPath,
        errorUploading,
      ];
}
