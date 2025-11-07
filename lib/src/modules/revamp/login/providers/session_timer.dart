import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sessionTimerProvider = Provider<SessionTimer>((_) => SessionTimer());

class SessionTimer {
  Timer? _timer;
  GoRouter? _router;
  String? _route;
  static const _sessionLength = Duration(minutes: 2);

  /// Call this right after a successful login.
  /// Subsequent user interaction can call [bump] to reset the 2‑minute countdown.
  void start(GoRouter router, {required String route}) {
    _router = router;
    _route = route;
    _restartTimer();
  }

  /// Reset the timer because the user touched / scrolled / typed.
  void bump() {
    if (_router == null || _route == null) return; // not running yet
    _restartTimer();
  }

  /// Call this on manual logout or when you leave the protected area
  void cancel() => _timer?.cancel();

  void _restartTimer() {
    _timer?.cancel();
    _timer = Timer(_sessionLength, () {
      if (_router != null && _route != null) {
        _router!.go(_route!);
      }
    });
  }
}
