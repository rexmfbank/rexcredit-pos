import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';

mixin AppGeolocation {
  Future<({bool success, String? reason})> checkLocationIsEnabled() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    debugPrintDev("Location Service Enabled: $isEnabled");
    if (!isEnabled) {
      return (success: false, reason: 'service');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    debugPrintDev("Location Permission: $permission");
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return (success: true, reason: null);
    } else {
      return (success: false, reason: 'permission');
    }
  }

  Future<Position?> getCurrentPosition() async {
    try {
      LocationSettings locationSettings;
      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          timeLimit: const Duration(seconds: 30),
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 15),
        );
      }

      final currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      return currentPosition;
    } catch (e) {
      debugPrintDev('Error getting current position: $e');
      debugPrintDev("Falling back to last known position");
      try {
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null) {
          debugPrintDev('Using last known position');
          return lastKnown;
        }
      } catch (e) {
        debugPrintDev("Error getting last known position: $e");
      }
      return null;
    }
  }

  Future<String> updateCurrentLocation() async {
    try {
      final position = await getCurrentPosition();
      if (position != null) {
        debugPrintDev(
          'LOC.UPDATE: ${position.latitude}, ${position.longitude}',
        );
        return '${position.latitude}, ${position.longitude}';
      } else {
        debugPrintDev('Error getting current position : position returns null');
        return '';
      }
    } catch (e) {
      debugPrintDev('Error updating current location: $e');
      return '';
    }
  }
}
