import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:livelyness_detection/livelyness_detection.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/model/face_detection_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/face_detection_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

String getTitle(LivelynessStep step) {
  switch (step) {
    case LivelynessStep.blink:
      return "Blink";
    case LivelynessStep.turnLeft:
      return "Turn Your Head Left";
    case LivelynessStep.turnRight:
      return "Turn Your Head Right";
    case LivelynessStep.smile:
      return "Smile";
  }
}

String getSubTitle(LivelynessStep step) {
  switch (step) {
    case LivelynessStep.blink:
      return "Detects Blink on the face visible in camera";
    case LivelynessStep.turnLeft:
      return "Detects Left Turn of the on the face visible in camera";
    case LivelynessStep.turnRight:
      return "Detects Right Turn of the on the face visible in camera";
    case LivelynessStep.smile:
      return "Detects Smile on the face visible in camera";
  }
}

class CapturedImageStatus extends ConsumerWidget {
  const CapturedImageStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faceDetect = ref.watch(faceDetectionProvider);
    switch (faceDetect.capturedImage) {
      case FaceCapturedImage.imageIsNull:
        return const _CaptureImageWidget(
          text: StringAssets.captureImage1,
          widget: Icon(Icons.cancel, color: AppColors.red2),
        );

      case FaceCapturedImage.imageIsNotNull:
        return const _CaptureImageWidget(
          text: StringAssets.captureImage2,
          widget: Icon(Icons.check, color: AppColors.rexGreen),
        );

      case FaceCapturedImage.imageIsUploading:
        return const _CaptureImageWidget(
          text: StringAssets.captureImage3,
          widget: CircularProgressIndicator(color: AppColors.rexPurpleLight),
        );

      case FaceCapturedImage.imageIsUploaded:
        return const _CaptureImageWidget(
          text: StringAssets.captureImage4,
          widget: Icon(Icons.check, color: AppColors.rexGreen),
        );

      case FaceCapturedImage.imageUploadError:
        return const _CaptureImageWidget(
          text: StringAssets.captureImage5,
          widget: Icon(Icons.cancel_rounded, color: AppColors.red2),
        );
    }
  }
}

class _CaptureImageWidget extends ConsumerWidget {
  const _CaptureImageWidget({
    required this.text,
    required this.widget,
  });

  final String text;
  final Widget widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(faceDetectionProvider.notifier).disableButton();
    return Padding(
      padding: EdgeInsets.only(
        left: 24.aw,
        right: 24.aw,
        top: 8.ah,
        bottom: 8.ah,
      ),
      child: Material(
        elevation: 4.0,
        shadowColor: AppColors.rexPurpleDark,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              widget,
            ],
          ),
        ),
      ),
    );
  }
}
