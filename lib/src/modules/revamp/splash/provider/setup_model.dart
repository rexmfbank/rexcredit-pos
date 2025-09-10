import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';

class SetupModel {
  final bool forceUpdate;
  final ForceUpdateInfo? updateInfo;

  const SetupModel({
    this.forceUpdate = false,
    this.updateInfo,
  });

  SetupModel copyWith({
    bool? forceUpdate,
    ForceUpdateInfo? updateInfo,
  }) {
    return SetupModel(
      forceUpdate: forceUpdate ?? this.forceUpdate,
      updateInfo: updateInfo ?? this.updateInfo,
    );
  }
}
