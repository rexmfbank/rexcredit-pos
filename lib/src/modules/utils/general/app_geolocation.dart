import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';

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
          accuracy: LocationAccuracy.medium,
          distanceFilter: 0,
          intervalDuration: const Duration(seconds: 10),
          timeLimit: const Duration(seconds: 15),
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

  /*Future<Position?> getCurrentPosition() async {
    try {
      // Fast path: try cached position first
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        debugPrintDev('Using cached last known position');
        return lastKnown;
      }

      // Slow path: get a fresh GPS fix
      LocationSettings locationSettings;
      if (Platform.isAndroid) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          intervalDuration: const Duration(seconds: 10),
          timeLimit: const Duration(seconds: 15),
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 15),
        );
      }

      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      debugPrintDev('Error getting current position: $e');
      return null;
    }
  }*/

  Future<({String lat, String long})> updateCurrentLocation2() async {
    try {
      final pos = await getCurrentPosition();
      if (pos != null) {
        debugPrintDev('LOC.UPDATE: ${pos.latitude}, ${pos.longitude}');
        return (lat: '${pos.latitude}', long: '${pos.longitude}');
      } else {
        debugPrintDev('Error getting current position : position returns null');
        return (lat: '', long: '');
      }
    } catch (e) {
      debugPrintDev('Error updating current location: $e');
      return (lat: '', long: '');
    }
  }
}
