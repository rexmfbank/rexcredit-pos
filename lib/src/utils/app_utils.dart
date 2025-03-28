import 'package:package_info_plus/package_info_plus.dart';

class AppUtils{

  static Future<String> appVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();
    return Future.value(packageInfo.version);
  }
}