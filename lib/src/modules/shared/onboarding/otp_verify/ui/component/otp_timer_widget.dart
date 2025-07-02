import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class OtpTimerWidget extends ConsumerStatefulWidget {
  const OtpTimerWidget({
    super.key,
    this.actionCode,
  });

  final String? actionCode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpTimerWidgetState();
}

class _OtpTimerWidgetState extends ConsumerState<OtpTimerWidget> {
  Duration _duration = const Duration(seconds: 60);
  Timer? _timer;
  int _countdownValue = 120;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_duration.inSeconds == -1) {
        setState(() {
          _isButtonEnabled = true;
          _timer?.cancel();
        });
      } else {
        setState(() {
          _countdownValue = _duration.inSeconds;
          _duration = _duration - const Duration(seconds: 1);
        });
      }
    });
  }

  void _onButtonPressed() async {
    ref.read(otpVerificationProvider.notifier).resendOtp(
          context: context,
          actionCode: widget.actionCode,
        );
    setState(() {
      _duration = const Duration(seconds: 60);
      _countdownValue = _duration.inSeconds;
      _isButtonEnabled = false;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _isButtonEnabled ? _onButtonPressed : null,
          style: TextButton.styleFrom(
              foregroundColor:
                  _isButtonEnabled ? AppColors.rexGreen : AppColors.grey3),
          child: Text(
            _isButtonEnabled ? StringAssets.otpTimer1 : StringAssets.otpTimer2,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 8.aw),
        Text(
          '$_countdownValue sec',
          style: const TextStyle(
            color: AppColors.rexBlack,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.solid,
          ),
        ),
      ],
    );
  }
}
