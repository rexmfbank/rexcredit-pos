import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';

/// This provider uses the 'network_info_plus' package to get
/// the IP address (IPv4 address) of the mobile device the app is
/// currently on. The 'String' value provided by the provider
/// is global.
final ipAddressProvider = FutureProvider<String>((ref) async {
  final info = NetworkInfo();
  final ipAddress = await info.getWifiIP();
  return ipAddress ?? 'null';
});

/// Constants for Device meta data information.
const String platformMobile = 'Mobile';
const String osAndroid = 'android';
const String osIOS = 'ios';

/// After getting the IP address of the mobile device, this provider
/// gets other data from the device e.g. the device id.
final deviceMetaProvider = FutureProvider<DeviceMetaData>((ref) async {
  final ipAddString = ref.watch(ipAddressProvider).asData?.value;
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return DeviceMetaData(
      deviceNumber: androidInfo.id,
      ipAddress: ipAddString ?? 'nil',
      platform: platformMobile,
      operatingSystem: osAndroid,
    );
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return DeviceMetaData(
      deviceNumber: iosInfo.identifierForVendor ?? 'nil',
      ipAddress: ipAddString ?? 'nil',
      platform: platformMobile,
      operatingSystem: osIOS,
    );
  }
  return DeviceMetaData.empty();
});
