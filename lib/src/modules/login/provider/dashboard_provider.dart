import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/api/dio/api_headers.dart';
import 'package:rex_app/src/modules/api/rex_api.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_state.dart';
import 'package:rex_app/src/modules/utils/general/app_functions.dart';
import 'package:rex_app/src/utils/app_keys.dart';

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);

class DashboardNotifier extends Notifier<DashboardState> {
  @override
  DashboardState build() {
    return DashboardState();
  }

  Future<void> fetchBalance() async {
    state = state.copyWith(balanceState: BalanceStateEnum.apiLoading);
    final config = AppKeysStorage.getConfig();
    final header = HeaderWithAuthNoCrypt(
      appVersion: config.appVersionLocal,
      deviceID: config.serialNumber,
      geoLong: config.longitude,
      geoLat: config.latitude,
      authToken: config.loginAuthToken,
    );
    //
    try {
      final res = await RexApi.instance.balance(header: header);
      if (res.balances.isNotEmpty) {
        state = state.copyWith(
          balanceState: BalanceStateEnum.apiSuccess,
          balanceAcctNo: res.balances.first.accountNumber,
          balanceAcctName: res.balances.first.accountName,
          balanceAcctType: res.balances.first.accountType,
          balanceAvailable: res.balances.first.availableBalance,
        );
        final update = config.copyWith(
          loginNuban: res.balances.first.accountNumber,
          loginFullname: res.balances.first.accountName,
        );
        await AppKeysStorage.saveConfig(update);
      } else {
        debugPrintDev("error fetching balance: no balances returned");
        state = state.copyWith(balanceState: BalanceStateEnum.apiFail);
      }
    } catch (err, _) {
      debugPrintDev("error fetching balance: $err");
      state = state.copyWith(balanceState: BalanceStateEnum.apiFail);
    }
  }
}
