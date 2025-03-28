import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final otpTimerProvider = NotifierProvider<OtpTimerNotifier, OtpTimerState>(
  () => OtpTimerNotifier(),
);

class OtpTimerNotifier extends Notifier<OtpTimerState> {
  Timer? _timer;
  @override
  OtpTimerState build() {
    return const OtpTimerState(
      countdownValue: 0,
      duration: Duration(seconds: 60),
    );
  }

  void countTimer() {
    // Duration _duration = const Duration(seconds: 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.duration.inSeconds == -1) {
        state = state.copyWith(
          duration: const Duration(seconds: 1),
          countdownValue: 0,
        );
        _timer?.cancel();

        //ref.read(otpVerificationProvider.notifier).toggleEnableResendOtp();
      } else {
        state = state.copyWith(
          duration: state.duration - const Duration(seconds: 1),
          countdownValue: state.duration.inSeconds,
        );
        // setState(() {
        //   _countdownValue = _duration.inSeconds;
        //   _duration = _duration - const Duration(seconds: 1);
        // });
      }
    });
  }
}

class OtpTimerState extends Equatable {
  final int countdownValue;
  final Duration duration;

  const OtpTimerState({
    required this.countdownValue,
    required this.duration,
  });

  OtpTimerState copyWith({
    int? countdownValue,
    Duration? duration,
  }) {
    return OtpTimerState(
      countdownValue: countdownValue ?? this.countdownValue,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [countdownValue, duration];
}
