// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_llc/model/llc_director_state.dart';
import 'package:rex_app/src/modules/shared/onboarding/set_transaction_pin/provider/set_transaction_pin_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_date_time.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

final llcDirectorProvider =
    NotifierProvider<LLC_DirectorNotifier, LLC_DirectorState>(
  () => LLC_DirectorNotifier(),
);

class LLC_DirectorNotifier extends Notifier<LLC_DirectorState> {
  @override
  LLC_DirectorState build() {
    return LLC_DirectorState(
      director1FirstName: TextEditingController(),
      director1MiddleName: TextEditingController(),
      director1LastName: TextEditingController(),
      director1Email: TextEditingController(),
      director1Mobile: TextEditingController(),
      director1Shares: TextEditingController(),
      director1BVN: TextEditingController(),
      director1Address: TextEditingController(),
      director1DOB: DateTime.now(),
      director1Gender: '',
      //
      director2FirstName: TextEditingController(),
      director2MiddleName: TextEditingController(),
      director2LastName: TextEditingController(),
      director2Email: TextEditingController(),
      director2Mobile: TextEditingController(),
      director2Shares: TextEditingController(),
      director2BVN: TextEditingController(),
      director2Address: TextEditingController(),
      director2DOB: DateTime.now(),
      director2Gender: '',
      //
      directors: [],
    );
  }

  void selectDOBForFirst(DateTime? value) {
    state = state.copyWith(director1DOB: value!);
  }

  void selectDOBForSecond(DateTime? value) {
    state = state.copyWith(director2DOB: value!);
  }

  void validateInput(BuildContext context) {
    if (state.director1FirstName.text.isBlank ||
        state.director1LastName.text.isBlank ||
        state.director1BVN.text.isBlank ||
        state.director1Mobile.text.isBlank ||
        state.director1Shares.text.isBlank ||
        state.director1Email.text.isBlank ||
        state.director2FirstName.text.isBlank ||
        state.director2LastName.text.isBlank ||
        state.director2Email.text.isBlank ||
        state.director2BVN.text.isBlank ||
        state.director2Mobile.text.isBlank ||
        state.director2Shares.text.isBlank) {
      showModalActionError(
        context: context,
        errorText: StringAssets.emptyDirector,
      );
    } else {
      _initializeDirectorList();
      _submitDirectors(context);
    }
  }

  void _submitDirectors(BuildContext context) async {
    final username = ref.watch(usernameProvider);
    final onboardingId = ref.watch(userOnboardingIdProvider);
    final accountType = ref.watch(userAccountTypeProvider);
    //
    final request = CompleteOnboardRequest(
      onboardingId: onboardingId,
      addressDto: const AddressDto(
        houseNumber: '',
        street: '',
        area: '',
        state: '',
        city: '',
        lga: '',
        country: '',
        longitude: 0,
        latitude: 0,
      ),
      username: username,
      gender: 'male',
      customerType: 'business',
      referralCode: '',
      language: 'en',
      employmentCategory: '',
      annualIncomeRange: '',
      nationalId: '',
      documents: [],
      businessDetailDto: BusinessDetailDto(
        businessType: accountType,
        registrationNumber: '',
        businessRegistered: '',
        businessRegistrationLink: '',
        businessEmail: '',
        businessAddress: '',
        taxNumber: '',
        mobileNumber: '',
        businessName: '',
        yearsInBusiness: 0,
        businessSector: '',
        businessLogo: '',
        directorInfoList: state.directors,
      ),
    );
    //
    LoadingScreen.instance().show(context: context);
    try {
      final res = await RexApi.instance.completeOnboard(request: request);
      LoadingScreen.instance().hide();
      showModalActionSuccess(
        context: context,
        subtitle: StringAssets.accountCreatedTitle(res.accountNumber ?? 'n/a'),
        onPressed: () {
          ref.read(setTransactionPinProvider.notifier).toggleFromSignUp(true);
          context.push(RouteName.setTransactionPin);
        },
      );
    } catch (error) {
      LoadingScreen.instance().hide();
      showModalActionError(context: context, errorText: error.toString());
    }
  }

  void _initializeDirectorList() {
    final entityCode = ref.watch(userEntityCodeProvider);
    //
    final one = BusinessDirectorInfo(
      entityCode: entityCode,
      customerId: '',
      firstName: state.director1FirstName.text,
      lastName: state.director1FirstName.text,
      middleName: state.director1MiddleName.text,
      email: state.director1Email.text,
      mobileNumber: state.director1Mobile.text,
      percentageOfShares: state.director1Shares.text,
      businessCode: '',
      bvn: state.director1BVN.text,
      address: state.director1Address.text,
      dateOfBirth: state.director1DOB.dateDDMMYYYY(),
      gender: state.director1Gender,
      photoLink: '',
    );
    //
    final two = BusinessDirectorInfo(
      entityCode: entityCode,
      customerId: '',
      firstName: state.director2FirstName.text,
      lastName: state.director2FirstName.text,
      middleName: state.director2MiddleName.text,
      email: state.director2Email.text,
      mobileNumber: state.director2Mobile.text,
      percentageOfShares: state.director2Shares.text,
      businessCode: '',
      bvn: state.director2BVN.text,
      address: state.director2Address.text,
      dateOfBirth: state.director2DOB.dateDDMMYYYY(),
      gender: state.director2Gender,
      photoLink: '',
    );
    state = state.copyWith(directors: [one, two]);
  }
}
