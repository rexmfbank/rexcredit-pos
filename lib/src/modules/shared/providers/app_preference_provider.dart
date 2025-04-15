import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/domain/pos_information.dart';
import 'package:rex_app/src/modules/shared/models/app_preference_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final userReferralCodeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final codeValue = prefs.getString(AppPreferenceKeys.userReferralCode) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userReferralCode, next);
  });
  return codeValue;
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

final userEmailProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final emailValue = prefs.getString(AppPreferenceKeys.userEmail) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userEmail, next);
  });
  return emailValue;
});

final userPhoneNumberProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final numberValue = prefs.getString(AppPreferenceKeys.userPhoneNumber) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userPhoneNumber, next);
  });
  return numberValue;
});

final userOnboardingIdProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final idValue = prefs.getString(AppPreferenceKeys.userOnboardingId) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userOnboardingId, next);
  });
  return idValue;
});

final userAuthTokenProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final authToken = prefs.getString(AppPreferenceKeys.userAuthToken);
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userAuthToken, next ?? 'null');
  });
  return authToken;
});

final userEntityCodeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final entityCodeValue = prefs.getString(AppPreferenceKeys.entityCode) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.entityCode, next);
  });
  return entityCodeValue;
});

final userNINProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final ninValue = prefs.getString(AppPreferenceKeys.userNin) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userNin, next);
  });
  return ninValue;
});

final userBVNProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final bvnValue = prefs.getString(AppPreferenceKeys.userBVN) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userBVN, next);
  });
  return bvnValue;
});

final userIncomeRangeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final aValue = prefs.getString(AppPreferenceKeys.userIncomeRange) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userIncomeRange, next);
  });
  return aValue;
});

final userEmploymentCategoryProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final aValue = prefs.getString(AppPreferenceKeys.userEmployment) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.userEmployment, next);
  });
  return aValue;
});

final userIsBusinessProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isValue = prefs.getBool(AppPreferenceKeys.userIsBusiness) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userIsBusiness, next);
  });
  return isValue;
});

final userIsIndividualProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isValue = prefs.getBool(AppPreferenceKeys.userIsIndividual) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.userIsIndividual, next);
  });
  return isValue;
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

final biometricsEnabledProvider = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isValue = prefs.getBool(AppPreferenceKeys.biometricsEnabled) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.biometricsEnabled, next);
  });
  return isValue;
});

final mobileTypeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final mobileType = prefs.getString(AppPreferenceKeys.mobileType) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.mobileType, next);
  });
  return mobileType;
});

final appVersionProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final appVersionValue = prefs.getString(AppPreferenceKeys.appVersion) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.appVersion, next);
  });
  return appVersionValue;
});

final posInfoProvider = StateProvider<PosInformation>((ref) {
  PosInformation posInfo = const PosInformation();
  ref.listenSelf((previous, next) {
    posInfo = next;
  });
  return posInfo;
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

final withdrawalLimitAmountProvider = StateProvider<double>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final withdrawalLimitAmountValue =
      prefs.getDouble(AppPreferenceKeys.withdrawalLimitAmount) ?? 0.0;
  ref.listenSelf((previous, next) {
    prefs.setDouble(AppPreferenceKeys.withdrawalLimitAmount, next);
  });
  return withdrawalLimitAmountValue;
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

final loanProductCodeProvider = StateProvider<String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final loanProductCodeValue =
      prefs.getString(AppPreferenceKeys.loanProductCode) ?? '';
  ref.listenSelf((previous, next) {
    prefs.setString(AppPreferenceKeys.loanProductCode, next);
  });
  return loanProductCodeValue;
});

final hideTargetSavingWallet = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isHidden =
      prefs.getBool(AppPreferenceKeys.hideTargetSavingBalance) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.hideTargetSavingBalance, next);
  });
  return isHidden;
});

final hideFixedDepositWallet = StateProvider<bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final isHidden =
      prefs.getBool(AppPreferenceKeys.hideFixedDepositBalance) ?? false;
  ref.listenSelf((previous, next) {
    prefs.setBool(AppPreferenceKeys.hideFixedDepositBalance, next);
  });
  return isHidden;
});

final isSecondTimeOpenProvider = StateProvider<bool?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getBool(AppPreferenceKeys.firstTimeRatingOpen);
});

final printingImageProvider = StateProvider<String?>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return prefs.getString(AppPreferenceKeys.assetImageSaved);
});
