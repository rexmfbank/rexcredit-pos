import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:rex_app/src/modules/shared/models/app_preference_keys.dart';

import '../providers/app_preference_provider.dart';

final appRatingServiceProvider = Provider<AppRatingService>((ref) {
  return AppRatingService(ref);
});

class AppRatingService {
  final InAppReview _inAppReview = InAppReview.instance;
  final Ref ref;

  AppRatingService(this.ref);

  bool isSecondTimeOpen() {
    final isSecondTime = ref.read(isSecondTimeOpenProvider);
    final prefs = ref.read(sharedPreferencesProvider);

    if (isSecondTime == null) {
      // First time opening app, set value to true and return false
      prefs.setBool(AppPreferenceKeys.firstTimeRatingOpen, true);
      ref.read(isSecondTimeOpenProvider.notifier).state = true;
      return false;
    } else if (isSecondTime) {
      // Second time opening, set to false and return true
      prefs.setBool(AppPreferenceKeys.firstTimeRatingOpen, false);
      ref.read(isSecondTimeOpenProvider.notifier).state = false;
      return true;
    } else {
      // Any subsequent opens, return false
      return false;
    }
  }

  Future<bool> showRating() async {
    try {
      final available = await _inAppReview.isAvailable();
      if (available) {
        _inAppReview.requestReview();
      } else {
        _inAppReview.openStoreListing(appStoreId: '6472193945');
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}