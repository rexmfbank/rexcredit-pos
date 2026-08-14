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

  static isLegit(String pkgName) {
    return pkgName == topwise ||
        pkgName == topwise2 ||
        pkgName == nexgo ||
        pkgName == nexgorex ||
        pkgName == telpo;
  }

  static const baseApplist = [
    horizon,
    nexgo,
    nexgorex,
    telpo,
    topwise,
    topwise2,
  ];
}
