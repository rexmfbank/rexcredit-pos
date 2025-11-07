import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rex_app/src/modules/shared/widgets/extension/snack_bar_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

mixin LocatorMix {
  Future<bool> handleLocationPermission(
    BuildContext context, {
    bool showModals = true, // Whether to display error modals to the user.
  }) async {
    // 1. Check if location services are enabled on the device.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (showModals && context.mounted) {
        context.showToast(
          message: Strings.enableDeniedLocation,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return false;
    }

    // 2. Attempt to get the current position directly.
    // This will throw a PermissionDeniedException if permissions are not granted.
    try {
      await Geolocator.requestPermission();
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      return true;
    } on PermissionDeniedException catch (_) {
      LocationPermission permission = await Geolocator.requestPermission();
      // 1. LocationPermission.denied
      if (permission == LocationPermission.denied) {
        if (showModals && context.mounted) {
          context.showToast(
            message: Strings.locationDenied,
            toastLength: Toast.LENGTH_LONG,
          );
        }
        return false;
      }
      // 2. LocationPermission.deniedForever
      if (permission == LocationPermission.deniedForever) {
        if (showModals && context.mounted) {
          showModalActionError(
            context: context,
            height: 190.ah,
            width: 190.aw,
            errorText: Strings.locationPermanentlyDenied,
            onTap: () async {
              if (Navigator.canPop(context)) Navigator.pop(context);
              try {
                final location = await Geolocator.getLastKnownPosition();
                if (location == null) {
                  await Geolocator.openAppSettings();
                  return;
                }
              } catch (e) {
                await Geolocator.openAppSettings();
              }
            },
          );
        }
        return false;
      }

      // If permission was granted after the request
      // (e.g., from 'denied' to 'whileInUse'),
      // try getting the position again to confirm full access.
      try {
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        return true;
      } catch (innerE) {
        // If a position still cannot be obtained even after permission was granted.
        if (showModals && context.mounted) {
          context.showToast(
            message: Strings.locationDenied,
            toastLength: Toast.LENGTH_LONG,
          );
        }
        return false;
      }
    } catch (e) {
      // Handle any other exceptions that might occur
      //(e.g., location service temporarily unavailable).
      if (showModals && context.mounted) {
        context.showToast(
          message: Strings.locationDenied,
          toastLength: Toast.LENGTH_LONG,
        );
      }
      return false;
    }
  }

  Future<Position?> getCurrentPosition(
    BuildContext context, {
    bool showModals = true,
  }) async {
    final hasPermission = await handleLocationPermission(
      context,
      showModals: showModals,
    );

    if (!hasPermission) return null;

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    return currentPosition;
  }

  Future<Position?> getCurrentPosition2() async {
    // final hasPermission = await handleLocationPermission(context);
    // if (!hasPermission) return null;

    final currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    return currentPosition;
  }

  Future<Placemark?> getAddressFromLatLng({
    required BuildContext context,
  }) async {
    final Position? position = await getCurrentPosition(context);
    if (position == null) return null;

    final place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return place[0];
  }

  Future<Placemark?> getAddressFromLatLng2() async {
    final Position? position = await getCurrentPosition2();
    if (position == null) return null;

    final place = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    return place[0];
  }

  Future<bool> isPermissionGranted(BuildContext context) async {
    return await handleLocationPermission(context);
  }
}
