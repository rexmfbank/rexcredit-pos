import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadModel extends Equatable {
  final File fileFromDevice;
  final String fileName;
  final String? documentName;
  final String? documentPath;

  const UploadModel({
    required this.fileFromDevice,
    required this.fileName,
     this.documentName,
     this.documentPath,
  });

  UploadModel copyWith({
    File? fileFromDevice,
    String? fileName,
    String? documentName,
    String? documentPath,
  }) {
    return UploadModel(
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
      fileName: fileName ?? this.fileName,
      documentName: documentName ?? this.documentName,
      documentPath: documentPath ?? this.documentPath,
    );
  }

  @override
  List<Object?> get props => [
    fileFromDevice,
    fileName,
    documentName,
    documentPath,
  ];
}
