import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/location_state.dart';

final locationStateProvider = NotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);

class LocationNotifier extends Notifier<LocationState> {
  @override
  LocationState build() {
    return LocationState();
  }

  bool get isPermissionPermanentlyDenied => state.isPermissionPermanentlyDenied;

  bool _isLocationPermissionGranted(LocationPermission permission) {
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  bool _isLocationPermissionDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  Future<void> checklocationIsEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    debugPrint("Location Permission: $permission");

    switch (permission) {
      case LocationPermission.always || LocationPermission.whileInUse:
        state = state.copyWith(
          isLocationServiceEnabled: true,
          isPermissionPermanentlyDenied: false,
        );
        break;
      case LocationPermission.denied:
        state = state.copyWith(
          isLocationServiceEnabled: false,
          isPermissionPermanentlyDenied: false,
        );
        break;
      case LocationPermission.deniedForever:
        state = state.copyWith(
          isLocationServiceEnabled: false,
          isPermissionPermanentlyDenied: true,
        );
        break;
      case LocationPermission.unableToDetermine:
        break;
    }
  }

  Future<void> requestLocationPermission() async {
    debugPrint('Checking current location permission status...');
    state = state.copyWith(isLoading: true);
    var permission = await Geolocator.requestPermission();
    debugPrint('Current permission status: $permission');

    switch (permission) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        state = state.copyWith(
          isLocationServiceEnabled: true,
          isLoading: false,
        );
        updateCurrentLocation();
        break;
      case LocationPermission.denied:
      case LocationPermission.deniedForever:
        state = state.copyWith(
          isLocationServiceEnabled: false,
          isPermissionPermanentlyDenied: true,
          isLoading: false,
        );
        break;
      case LocationPermission.unableToDetermine:
        state = state.copyWith(isLoading: false);
        break;
    }
  }

  Future<Position?> getCurrentPosition() async {
    try {
      final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      return currentPosition;
    } catch (e) {
      debugPrint('Error getting current position: $e');
      return null;
    }
  }

  Future<void> updateCurrentLocation() async {
    try {
      final position = await getCurrentPosition();
      if (position != null) {
        state = state.copyWith(currentPosition: position);
        debugPrint('LOC.UPDATE: ${position.latitude}, ${position.longitude}');
      } else {
        debugPrint('Error getting current position : position returns null');
      }
    } catch (e) {
      debugPrint('Error updating current location: $e');
    }
  }

  Future<void> openLocationSettings() async {
    try {
      debugPrint('Opening app settings for location permission...');
      await Geolocator.openAppSettings();
    } catch (e) {
      debugPrint('Error opening app settings: $e');
    }
  }
}
