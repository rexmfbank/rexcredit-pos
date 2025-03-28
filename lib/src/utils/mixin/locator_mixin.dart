import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

mixin LocatorMix {
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        showModalActionError(
          context: context,
          errorText: StringAssets.enableDeniedLocation,
        );
      }
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          showModalActionError(
            context: context,
            height: 190.ah,
            width: 190.aw,
            lottieAnimation: LottieAsset.locationAnimation,
            errorText: StringAssets.locationDenied,
          );
        }
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        showModalActionError(
          context: context,
          height: 190.ah,
          width: 190.aw,
          lottieAnimation: LottieAsset.locationAnimation,
          errorText: StringAssets.locationPermanentlyDenied,
          onTap: () => Geolocator.openAppSettings(),
        );
      }
      return false;
    }
    return true;
  }

  Future<Position?> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (!hasPermission) return null;

    final currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
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

  Future<bool> isPermissionGranted(BuildContext context) async {
    return await _handleLocationPermission(context);
  }
}
