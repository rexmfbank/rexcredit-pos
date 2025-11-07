// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/providers/location_state.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

class LocationStateNotifier extends StateNotifier<LocationState> {
  final Ref ref;
  LocationStateNotifier(this.ref) : super(const LocationState());

  bool get isPermissionPermanentlyDenied => state.isPermissionPermanentlyDenied;

  Future<void> checklocationIsEnabled() async {
    final isFirstLaunch = ref.watch(sharedPreferencesProvider);
    final isFirstTimeUser = isFirstLaunch.getBool("isFirstLaunch") ?? true;
    final permission = await Geolocator.checkPermission();

    // First time user with denied permission - don't update location
    if (isFirstTimeUser && permission == LocationPermission.denied) {
      state = state.copyWith(isLocationServiceEnabled: false);
      return;
    }

    // Permission granted - update location
    if (_isLocationPermissionGranted(permission) && !isFirstTimeUser) {
      state = state.copyWith(isLocationServiceEnabled: true);
      await _updateCurrentLocation(showModals: false);
      return;
    }

    // Returning user with denied permission
    if (!isFirstTimeUser && _isLocationPermissionDenied(permission)) {
      final isPermanentlyDenied =
          permission == LocationPermission.deniedForever;
      state = state.copyWith(
        isLocationServiceEnabled: false,
        isPermissionPermanentlyDenied: isPermanentlyDenied,
      );
    }
  }

  bool _isLocationPermissionGranted(LocationPermission permission) {
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  bool _isLocationPermissionDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  Future<void> requestLocationPermission() async {
    final isFirstLaunch = ref.watch(sharedPreferencesProvider);
    isFirstLaunch.setBool("isFirstLaunch", false);

    state = state.copyWith(isLoading: true);
    var permission = await Geolocator.requestPermission();

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        state = state.copyWith(
          isLocationServiceEnabled: true,
          isLoading: false,
        );
        _updateCurrentLocation();
        break;

      case LocationPermission.denied || LocationPermission.deniedForever:
        state = state.copyWith(
          isLocationServiceEnabled: false,
          isPermissionPermanentlyDenied: true,
          isLoading: false,
        );

        break;

      case LocationPermission.unableToDetermine:
        break;
    }
  }

  /// Open app settings for location permission
  Future<void> openLocationSettings() async {
    try {
      await Geolocator.openAppSettings();
    } catch (e) {
      //
    }
  }

  /// Get current position
  Future<Position?> _getCurrentPosition({bool showModals = true}) async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return currentPosition;
    } catch (e) {
      return null;
    }
  }

  /// Update current location in state
  Future<void> _updateCurrentLocation({bool showModals = false}) async {
    try {
      final position = await _getCurrentPosition(showModals: showModals);
      if (position != null) {
        state = state.copyWith(currentPosition: position);
      }
    } catch (e) {
      //
    }
  }

  Future<void> refreshLocation(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _updateCurrentLocation();
    state = state.copyWith(isLoading: false);
  }
}

final locationStateProvider =
    StateNotifierProvider<LocationStateNotifier, LocationState>(
      (ref) => LocationStateNotifier(ref),
    );
