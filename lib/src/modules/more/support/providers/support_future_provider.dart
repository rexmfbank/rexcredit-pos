import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/data/rex_api/rex_api.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';

final supportFutureProvider =
    FutureProvider.family<ContactCareData, BuildContext>((ref, context) async {
  final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
  try {
    final supportInfo =
        await RexApi.instance.getContactAndCareInfo(token: authToken);
    return supportInfo.data;
  } catch (e) {
    if (context.mounted) {
      // context.showToast(message: StringAssets.errorOccurredContacts);
    }
    return const ContactCareData.empty();
  }
});

final supportFutureProvider2 = FutureProvider<ContactCareData>((ref) async {
  final authToken = ref.watch(appAuthTokenProvider) ?? 'null';
  try {
    final supportInfo =
        await RexApi.instance.getContactAndCareInfo(token: authToken);
    return supportInfo.data;
  } catch (e) {
    return const ContactCareData.empty();
  }
});
