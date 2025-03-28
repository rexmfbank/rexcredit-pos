import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:livelyness_detection/livelyness_detection.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/face_detection_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/ui/components/face_detection_component.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class RegisterFaceDetectionScreen extends ConsumerStatefulWidget {
  const RegisterFaceDetectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterFaceDetectionScreenState();
}

class _RegisterFaceDetectionScreenState
    extends ConsumerState<RegisterFaceDetectionScreen> {
  //
  String? _capturedImagePath;
  final List<LivelynessStepItem> _verificationSteps = [];

  @override
  void initState() {
    _initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final faceDetect = ref.watch(faceDetectionProvider);
    return Scaffold(
      appBar: RexAppBar(
        step: StringAssets.emptyString,
        shouldHaveBackButton: true,
        title: StringAssets.createAccountTitle,
        subtitle: StringAssets.registerPic,
        onBackButtonPressed: () {
          context.go(RouteName.registerFaceDetect);
        },
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw, vertical: 8.ah),
            child: SizedBox(
              height: 270.ah,
              width: 150.aw,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.rexBackground,
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  border: Border.all(
                    color: AppColors.rexPurpleLight,
                    width: 2.5,
                  ),
                ),
                child: _capturedImagePath == null
                    ? LottieBuilder.asset(LottieAsset.addProfilePicture)
                    : Image.file(
                        File(_capturedImagePath ?? ""),
                        fit: BoxFit.contain,
                      ),
              ),
            ),
          ),
          const CapturedImageStatus(),
          Center(
            child: RexElevatedButton(
              isDisabled: faceDetect.isDisabled,
              onPressed: () {
                faceDetect.continueRegistration
                    ? context.push(RouteName.register2)
                    : _onStartLivelyness();
              },
              buttonTitle: faceDetect.continueRegistration
                  ? StringAssets.registerPic2
                  : StringAssets.registerPic3,
            ),
          ),
          SizedBox(height: 10.ah),
          Padding(
            padding: EdgeInsets.only(left: 16.aw, right: 16.aw),
            child: Text(
              StringAssets.profilePictureInstructionsHeader,
              style: AppTextStyles.body1Regular,
            ),
          ),
          SizedBox(height: 10.ah),
          Padding(
            padding: EdgeInsets.only(left: 16.aw, right: 16.aw),
            child: Text(
              StringAssets.profilePictureInstructions2,
              style: AppTextStyles.body1Regular.copyWith(
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _initValues() {
    _verificationSteps.addAll(
      [
        LivelynessStepItem(
          step: LivelynessStep.smile,
          title: StringAssets.livelyStep1,
          isCompleted: false,
        ),
        LivelynessStepItem(
          step: LivelynessStep.blink,
          title: StringAssets.livelyStep2,
          isCompleted: false,
        ),
      ],
    );
    LivelynessDetection.instance.configure(
      thresholds: [
        SmileDetectionThreshold(
          probability: 0.8,
        ),
        BlinkDetectionThreshold(
          leftEyeProbability: 0.25,
          rightEyeProbability: 0.25,
        ),
      ],
    );
  }

  void _onStartLivelyness() async {
    setState(() => _capturedImagePath = null);
    final response = await LivelynessDetection.instance.detectLivelyness(
      context,
      config: DetectionConfig(
        steps: _verificationSteps,
        startWithInfoScreen: false,
        maxSecToDetect: 20,
        allowAfterMaxSec: false,
        captureButtonColor: Colors.red,
      ),
    );
    if (response == null) return;

    setState(() {
      _capturedImagePath = response.imgPath;
    });
    ref.read(faceDetectionProvider.notifier).setImage(_capturedImagePath);
  }
}
