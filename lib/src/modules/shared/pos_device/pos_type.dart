enum PosType {
  nexgo("com.nexgo.apiv3", "NEXGO"),
  nexgorex("com.nexgo.apiv3.rexMfb", "NEXGOREX"),
  topwise("com.globalaccelerex.topwisebase", "TOPWISE"),
  telpo("com.accelerexnetwork.telpobaseapp", "TELPO"),
  horizon("com.globalaccelerex.horizonbaseapp", "HORIZON");

  const PosType(
    this.pkgName,
    this.model,
  );

  final String pkgName;
  final String model;
}

enum PosDevice { nexgo, nexgorex, topwise, telpo, horizon, none }

abstract class PosBaseApp {
  static const nexgo = 'com.nexgo.apiv3';
  static const nexgorex = 'com.nexgo.apiv3.rexMfb';
  static const topwise = 'com.globalaccelerex.topwisebase';
  static const telpo = 'com.accelerexnetwork.telpobaseapp';
  static const horizon = 'com.globalaccelerex.horizonbaseapp';

  static const none = '';
}
