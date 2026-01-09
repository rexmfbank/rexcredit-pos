import 'package:geolocator/geolocator.dart';
import 'package:rex_app/src/modules/revamp/utils/app_functions.dart';

mixin LocatorMixNew {
  Future<bool> checklocationIsEnabled() async {
    LocationPermission permission = await Geolocator.checkPermission();
    debugPrintDev("Location Permission: $permission");

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
      debugPrintDev('Error getting current position: $e');
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

  Future<void> openLocationSettings() async {
    try {
      debugPrintDev('Opening app settings for location permission...');
      await Geolocator.openAppSettings();
    } catch (e) {
      debugPrintDev('Error opening app settings: $e');
    }
  }
}
