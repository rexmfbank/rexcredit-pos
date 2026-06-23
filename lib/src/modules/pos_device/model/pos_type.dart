enum PosType {
  nexgo("com.nexgo.apiv3", "NEXGO"),
  nexgorex("com.nexgo.apiv3.rexMfb", "NEXGOREX"),
  topwise("com.globalaccelerex.topwisebase", "TOPWISE"),
  topwise2(
    "com.globalaccerex.pos.android_accelerex_purchase.topwise",
    "TOPWISE2",
  ),
  telpo("com.accelerexnetwork.telpobaseapp", "TELPO"),
  horizon("com.globalaccelerex.horizonbaseapp", "HORIZON");

  const PosType(this.pkgName, this.model);

  final String pkgName;
  final String model;
}

enum PosDevice { nexgo, nexgorex, topwise, topwise2, telpo, horizon, none }

abstract class Pkg {
  static const nexgo = 'com.nexgo.apiv3';
  static const nexgorex = 'com.nexgo.apiv3.rexMfb';
  static const topwise = 'com.globalaccelerex.topwisebase';
  static const topwise2 =
      'com.globalaccelerex.pos.android_accelerex_purchase.topwise';
  static const telpo = 'com.accelerexnetwork.telpobaseapp';
  static const horizon = 'com.globalaccelerex.horizonbaseapp';

  static const transaction = 'com.globalaccelerex.transaction';

  static const none = '';

  static isTopwise(String pkgName) {
    return pkgName == topwise || pkgName == topwise2;
  }
}
