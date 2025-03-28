import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

/// Provider that gets the data for the bank uptime data from the backend
final bankUptimeProvider = FutureProvider<BankUptimeResponse>((ref) async {
  final authToken = ref.watch(userAuthTokenProvider) ?? '';
  final uptime = RexApi.instance.bankUptime(authToken: authToken);
  return uptime;
});
