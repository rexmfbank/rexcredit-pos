import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ReceiptViewModel {
  final bool isLoading;
  final GlobalKey globalKey;
  final ScreenshotController screenshotController;

  ReceiptViewModel({
    required this.globalKey,
    required this.screenshotController,
    this.isLoading = false,
  });

  @override
  ReceiptViewModel copyWith({
    bool? isLoading,
    GlobalKey? globalKey,
    ScreenshotController? screenshotController,
  }) {
    return ReceiptViewModel(
      isLoading: isLoading ?? this.isLoading,
      globalKey: globalKey ?? this.globalKey,
      screenshotController: screenshotController ?? this.screenshotController,
    );
  }
}
