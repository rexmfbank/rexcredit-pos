import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

mixin LocatorMixNew {
  Future<bool> checklocationIsEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    debugPrint("Location Permission: $permission");

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
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

  Future<String> updateCurrentLocation() async {
    try {
      final position = await getCurrentPosition();
      if (position != null) {
        debugPrint('LOC.UPDATE: ${position.latitude}, ${position.longitude}');
        return '${position.latitude}, ${position.longitude}';
      } else {
        debugPrint('Error getting current position : position returns null');
        return '';
      }
    } catch (e) {
      debugPrint('Error updating current location: $e');
      return '';
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
