import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/api/dio/interceptors.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/modules/utils/routes/routes_top.dart';

class InternetNotification {
  static StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;
  static OverlayEntry? _connectivityOverlay;
  static bool _isShowingBanner = false;
  static Timer? _dismissTimer;
  static bool _isDismissedTemporarily = false;

  static void init() {
    debugPrintDev("INTERNET NOTIFICATION INITIALIZED");
    startConnectivityListener();
  }

  static void startConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      // Deep check — verifies the app can actually reach the server
      final isConnected = await ConnectionCheck.isConnected();

      if (isConnected) {
        if (_isShowingBanner) {
          _removeConnectivityBanner();
        }
        _isDismissedTemporarily = false;
        _dismissTimer?.cancel();
      } else if (!isConnected &&
          !_isShowingBanner &&
          !_isDismissedTemporarily) {
        _showConnectivityBanner();
      }
    });
  }

  static void _showConnectivityBanner() {
    final context = rootNavKey.currentState?.overlay?.context;
    if (context == null) return;

    _connectivityOverlay = OverlayEntry(
      builder: (context) {
        return InternetNotif(
          onPressed: () {
            _dismissBannerTemporarily();
          },
        );
      },
    );

    rootNavKey.currentState?.overlay?.insert(_connectivityOverlay!);
    _isShowingBanner = true;
  }

  static void _dismissBannerTemporarily() {
    _removeConnectivityBanner();
    _isDismissedTemporarily = true;
    _dismissTimer?.cancel();
    _dismissTimer = Timer(const Duration(minutes: 1), () async {
      _isDismissedTemporarily = false;
      final isConnected = await ConnectionCheck.isConnected();
      if (!isConnected && !_isShowingBanner) {
        _showConnectivityBanner();
      }
    });
  }

  static void _removeConnectivityBanner() {
    _connectivityOverlay?.remove();
    _connectivityOverlay = null;
    _isShowingBanner = false;
  }
}

class InternetNotif extends StatelessWidget {
  const InternetNotif({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        child: Container(
          color: Colors.red.shade700,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(Icons.wifi_off, color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Internet connection unstable. Please try again shortly',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade900,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: onPressed,
                child: const Text('Dismiss', style: TextStyle(fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
