import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/models/app_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final userFirstNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final nameValue = prefs.getString(AppPreferenceKeys.userFirstName) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userFirstName, next);
  });
  return nameValue;
});

final userFullNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final fullNameValue = prefs.getString(AppPreferenceKeys.userFullName) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userFullName, next);
  });
  return fullNameValue;
});

final usernameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final usernameValue = prefs.getString(AppPreferenceKeys.username) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.username, next);
  });
  return usernameValue;
});

final userNubanProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final nuban = prefs.getString(AppPreferenceKeys.userNuban) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userNuban, next);
  });
  return nuban;
});

final userAccountTypeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final val = prefs.getString(AppPreferenceKeys.userAccountType) ?? 'null';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userAccountType, next);
  });
  return val;
});

final userPassProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final val = prefs.getString(AppPreferenceKeys.userPass) ?? 'N';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userPass, next);
  });
  return val;
});

final mobileTypeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final mobileType = prefs.getString(AppPreferenceKeys.mobileType) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.mobileType, next);
  });
  return mobileType;
});

final emptyNubanProvider = StateProvider<bool>((ref) {
  final nuban = ref.watch(userNubanProvider);
  return nuban.isEmpty;
});

final isUserProfileCompletedProvider = StateProvider<bool?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isUserProfileCompleted = prefs.getBool(AppPreferenceKeys.isUserProfile);
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.isUserProfile, next ?? false);
  });
  return isUserProfileCompleted;
});

final verifiedNextOfKinProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final verifiedKin = prefs.getBool(AppPreferenceKeys.userNextOfKin) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userNextOfKin, next);
  });
  return verifiedKin;
});

final verifiedBvnProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final verifiedBvn = prefs.getBool(AppPreferenceKeys.userBvn) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userBvn, next);
  });
  return verifiedBvn;
});

final verifiedSecurityQuestionProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final verifiedQuestion =
      prefs.getBool(AppPreferenceKeys.userSecurityQuestion) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userSecurityQuestion, next);
  });
  return verifiedQuestion;
});

final verifiedDocumentProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final verifiedDocs =
      prefs.getBool(AppPreferenceKeys.userDocumentAdded) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userDocumentAdded, next);
  });
  return verifiedDocs;
});

final verifiedAllDocuments = Provider<bool>((ref) {
  final bvn = ref.watch(verifiedBvnProvider);
  final kin = ref.watch(verifiedNextOfKinProvider);
  final docs = ref.watch(verifiedDocumentProvider);
  if (bvn && kin && docs) {
    return true;
  } else {
    return false;
  }
});

final hideAccountProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isHidden = prefs.getBool(AppPreferenceKeys.hideAccountBalance) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.hideAccountBalance, next);
  });
  return isHidden;
});

final businessCodeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final businessCodeValue =
      prefs.getString(AppPreferenceKeys.businessCode) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.businessCode, next);
  });
  return businessCodeValue;
});

final isSecondTimeOpenProvider = StateProvider<bool?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(AppPreferenceKeys.firstTimeRatingOpen);
});

/// PROVIDERS FOR REVAMPED UI
/// ANYTHING ABOVE THIS COMMENT SHOULD BE MOVED BELOW
/// THIS COMMENT IF IT IS NEEDED OR DELETED

final appAuthTokenProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.authTokenApp);
});

final posAuthTokenProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.authTokenTerminal);
});

final appVersionProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.appVersion) ?? '';
});

final baseAppNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.baseAppPkg) ?? '';
});

final printingImageProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.assetImageSaved);
});

final serialNumberProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.posSerialNumber) ?? '';
});

final terminalIdProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.posTerminalId) ?? '';
});

final merchantNameProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.posMerchantName) ?? '';
});

final merchantNubanProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.posMerchantNuban) ?? '';
});
