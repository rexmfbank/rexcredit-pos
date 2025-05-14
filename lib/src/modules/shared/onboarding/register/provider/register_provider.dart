// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/models/device_meta_data.dart';
import 'package:rex_app/src/modules/shared/onboarding/otp_verify/provider/otp_verification_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/model/register_screen_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/register/provider/face_detection_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/providers/meta_data_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/mixin/locator_mixin.dart';

final registerProvider =
    NotifierProvider<RegisterNotifier, RegisterScreenState>(
  () => RegisterNotifier(),
);

class RegisterNotifier extends Notifier<RegisterScreenState> with LocatorMix {
  DeviceMetaData? meta;
  Timer? _timer;

  @override
  RegisterScreenState build() {
    meta = ref.watch(deviceMetaProvider).asData?.value;
    return RegisterScreenState(
      firstNameController: TextEditingController(),
      middleNameController: TextEditingController(),
      surnameController: TextEditingController(),
      usernameController: TextEditingController(),
      passwordController: TextEditingController(),
      passwordConfirmController: TextEditingController(),
      bvnController: TextEditingController(),
      ninController: TextEditingController(),
      emailController: TextEditingController(),
      phoneController: TextEditingController(),
      dobController: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      dateOfBirth: null,
      passwordNotMatch: false,
      employmentCategory: '',
      annualIncomeRange: '',
      enableSubmission: true,
    );
  }

  void onGenderDropdownChange(String? value) {
    state = state.copyWith(gender: value!);
  }

  void onEmploymentCategoryDropdownChange(String? value) {
    state = state.copyWith(employmentCategory: value!);
  }

  void onAnnualIncomeRangeDropdownChange(String? value) {
    state = state.copyWith(annualIncomeRange: value!);
  }

  void onDateSelectionChange(DateTime? value) {
    state = state.copyWith(dateOfBirth: value!);
  }

  void onCheckBoxChanged(bool? value) {
    state = state.copyWith(termsAndCondition: value!);
  }

  final businessDetailDto = const BusinessDetailDto(
    businessType: StringAssets.noData,
    registrationNumber: StringAssets.noData,
    businessRegistered: StringAssets.noData,
    businessRegistrationLink: StringAssets.noData,
    businessEmail: StringAssets.noData,
    businessAddress: StringAssets.noData,
    taxNumber: StringAssets.noData,
    mobileNumber: StringAssets.noData,
    businessName: StringAssets.noData,
    yearsInBusiness: 1,
    businessSector: StringAssets.noData,
    businessLogo: StringAssets.noData,
    directorInfoList: [],
  );

  void confirmPassword({
    required String text,
    required BuildContext context,
  }) {
    _timer?.cancel();
    _startTimer(text, context);
  }

  void _startTimer(String text, BuildContext context) {
    _timer = Timer(const Duration(milliseconds: 600), () {
      if (state.passwordController.text !=
          state.passwordConfirmController.text) {
        state = state.copyWith(passwordNotMatch: true);
      } else {
        state = state.copyWith(passwordNotMatch: false);
      }
    });
  }

  void validateInput1(BuildContext context) {
    if (state.firstNameController.text.isEmpty ||
        state.surnameController.text.isEmpty ||
        state.phoneController.text.isEmpty ||
        state.bvnController.text.isEmpty ||
        state.ninController.text.isEmpty ||
        state.emailController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: StringAssets.registerCheck1,
      );
    } else {
      context.push(Routes.registerFaceDetect);
    }
  }

  void validateInputAndRegister(BuildContext context) {
    if (state.usernameController.text.isEmpty ||
        state.passwordController.text.isEmpty) {
      showModalActionError(
        context: context,
        errorText: StringAssets.registerCheck2,
      );
    } else if (state.termsAndCondition == false) {
      showModalActionError(
        context: context,
        title: StringAssets.validationError,
        errorText: StringAssets.termsAndConditionError,
      );
    } else if (state.dateOfBirth == null) {
      showModalActionError(
        context: context,
        errorText: StringAssets.checkDOB,
      );
    } else if (state.employmentCategory == '' ||
        state.annualIncomeRange == '') {
      showModalActionError(
        context: context,
        errorText: StringAssets.checkRegisterDropdown,
      );
    } else {
      register(context);
    }
  }

  Future<void> register(BuildContext context) async {
    final picture = ref.watch(faceDetectionProvider);
    Position? position = await getCurrentPosition(context);
    Placemark? placemark = await getAddressFromLatLng(context: context);
    //
    final personalDetailDto = PersonalDetailDto(
      firstName: state.firstNameController.text,
      lastName: state.surnameController.text,
      middleName: state.middleNameController.text.isBlank
          ? ""
          : state.middleNameController.text,
      mobileNumber: state.phoneController.text,
      email: state.emailController.text,
      dateOfBirth: state.dateOfBirth!.dateYYYYMMDD(),
      gender: state.gender,
      photoLink: picture.documentPath,
      employmentStatus: '',
      occupation: state.occupation,
      bvn: state.bvnController.text,
    );
    //
    final request = RegisterRequest(
      customerType: 'individual',
      personalDetailDto: personalDetailDto,
      businessDetailDto: businessDetailDto,
      onboardingId: state.onboardingId,
      password: state.passwordController.text,
      bvn: state.bvnController.text,
      nationalId: state.ninController.text,
      language: 'en',
      username: state.usernameController.text.trim(),
      termsAndCondition: state.termsAndCondition,
      countryCode: 'ng',
      meta: ApiDeviceMeta(
        os: meta?.operatingSystem ?? '',
        ip: meta?.ipAddress ?? '',
        platform: meta?.platform ?? '',
        deviceId: meta?.deviceNumber ?? '',
        terminalId: '',
        geolocation: "${position?.latitude}, ${position?.longitude}",
        locationName: "${placemark?.street}, ${placemark?.country}",
      ),
      employmentCategory: state.employmentCategory,
      annualIncomeRange: state.annualIncomeRange,
    );
    //
    _saveDetails();
    if (await isPermissionGranted(context)) {
      state = state.copyWith(enableSubmission: false);
      LoadingScreen.instance().show(context: context);
      try {
        await RexApi.instance.register(
          appVersion: ref.read(appVersionProvider),
          request: request,
        );
        LoadingScreen.instance().hide();
        ref.read(otpVerificationProvider.notifier).resendOtp(context: context);
        context.push(Routes.otpVerify);
      } catch (error) {
        LoadingScreen.instance().hide();
        state = state.copyWith(enableSubmission: true);
        if (context.mounted) {
          showModalActionError(context: context, errorText: error.toString());
        }
      }
    }
  }

  void _saveDetails() {
    ref.read(usernameProvider.notifier).state =
        state.usernameController.text.trim();
    ref.read(userPassProvider.notifier).state = state.passwordController.text;
    ref.read(userPhoneNumberProvider.notifier).state =
        state.phoneController.text;
    ref.read(userOnboardingIdProvider.notifier).state = state.onboardingId;
    ref.read(userNINProvider.notifier).state = state.ninController.text;
    ref.read(userIncomeRangeProvider.notifier).state = state.annualIncomeRange;
    ref.read(userEmploymentCategoryProvider.notifier).state =
        state.employmentCategory;
  }
}
