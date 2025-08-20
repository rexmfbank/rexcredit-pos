import 'dart:io';

class FileUploadModel {
  final bool isLoading;
  final String? fileName;
  final File? fileFromDevice;

  const FileUploadModel({
    this.isLoading = false,
    this.fileName,
    this.fileFromDevice,
  });

  FileUploadModel copyWith({
    bool? isLoading,
    String? fileName,
    File? fileFromDevice,
  }) {
    return FileUploadModel(
      isLoading: isLoading ?? this.isLoading,
      fileName: fileName ?? this.fileName,
      fileFromDevice: fileFromDevice ?? this.fileFromDevice,
    );
  }
}
