import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';

final appCountryProvider =
    FutureProvider.autoDispose<List<AppCountry>>((ref) async {
  final res = await RexApi.instance.appCountries();
  return res.data;
});
