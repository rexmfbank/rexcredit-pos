import 'package:hooks_riverpod/hooks_riverpod.dart';

final registerNumberProvider = StateProvider<String>((ref) {
  return "";
});

final registerEmailProvider = StateProvider<String>((ref) {
  return "";
});

final registerUsernameProvider = StateProvider<String>((ref) {
  return "";
});

final registerTermsProvider = StateProvider<bool>((ref) {
  return false;
});

final otpTextProvider = StateProvider.autoDispose<String>((ref) {
  return "";
});

/// provider for birth date
final registerBirthDateProvider =
    NotifierProvider<RegisterBirthDateNotifier, DateTime>(() {
  return RegisterBirthDateNotifier();
});

class RegisterBirthDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void changeDate(DateTime? value) {
    state = value ?? state;
  }
}
