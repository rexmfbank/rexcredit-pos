import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/next_of_kin_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/next_of_kin_birth_date.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/next_of_kin_dropdown.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../../shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import '../../providers/add_next_of_kin_api_provider.dart';
import '../../providers/get_next_of_kin_future_provider.dart';

class NextOfKinScreen extends ConsumerStatefulWidget {
  const NextOfKinScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NextOfKinState();
}

class _NextOfKinState extends ConsumerState<NextOfKinScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(getNextOfKinFutureProvider);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(nextOfKinNotifier);

    //
    ref.listen(
      addNextOfKinApiProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            ref.read(verifiedNextOfKinProvider.notifier).state = true;
            showSuccessModal(
              context,
              StringAssets.nextOfKinAdded,
              StringAssets.successDescription,
              StringAssets.ok,
              StringAssets.successTick,
              () {
                context.pop();
                context.pop();
                context.go(
                  "${RouteName.dashboardMore}/${RouteName.nextOfKin}",
                );
              },
            );
          },
          error: (error, stackTrace) {
            LoadingScreen.instance().hide();
            showModalActionError(
              context: context,
              errorText: error.toString(),
            );
          },
          loading: () {
            LoadingScreen.instance().show(context: context);
          },
        );
      },
    );
    //
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.kinTitle,
        subtitle: StringAssets.kinSubtitle,
      ),
      body: Stack(children: [
        Form(
          key: provider.formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ref.watch(getNextOfKinFutureProvider).maybeWhen(
                    data: (data) {
                      if (data.firstName.isNotBlank) {
                        return RexTextField(
                          outerTitle: StringAssets.firstNameTitle,
                          showOuterTile: true,
                          controller: provider.firstNameController,
                          obscureText: false,
                          hintText: data.firstName,
                          readOnly: data.firstName.isNotBlank,
                          validator: (value) => TextfieldValidator.name(value),
                          inputType: TextInputType.name,
                        );
                      }
                      return RexTextField(
                        outerTitle: StringAssets.firstNameTitle,
                        showOuterTile: true,
                        hintText: StringAssets.firstNameHint,
                        controller: provider.firstNameController,
                        obscureText: false,
                        validator: (value) => TextfieldValidator.name(value),
                        inputType: TextInputType.name,
                      );
                    },
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.firstNameTitle,
                      showOuterTile: true,
                      hintText: StringAssets.firstNameHint,
                      controller: provider.firstNameController,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.name(value),
                      inputType: TextInputType.name,
                    ),
                  ),
              ref.watch(getNextOfKinFutureProvider).maybeWhen(
                    data: (data) {
                      if (data.lastName.isNotBlank) {
                        return RexTextField(
                          outerTitle: StringAssets.lastNameTitle,
                          showOuterTile: true,
                          controller: provider.lastNameController,
                          obscureText: false,
                          hintText: data.lastName,
                          readOnly: data.lastName.isNotBlank,
                          validator: (value) => TextfieldValidator.name(value),
                          inputType: TextInputType.name,
                        );
                      }
                      return RexTextField(
                        outerTitle: StringAssets.lastNameTitle,
                        showOuterTile: true,
                        hintText: StringAssets.lastNameHint,
                        controller: provider.lastNameController,
                        obscureText: false,
                        validator: (value) => TextfieldValidator.name(value),
                        inputType: TextInputType.name,
                      );
                    },
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.lastNameTitle,
                      showOuterTile: true,
                      hintText: StringAssets.lastNameHint,
                      controller: provider.lastNameController,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.name(value),
                      inputType: TextInputType.name,
                    ),
                  ),
              ref.watch(getNextOfKinFutureProvider).maybeWhen(
                    data: (data) {
                      if (data != GetNextOfKinData.empty()) {
                        return RexTextField(
                          outerTitle: StringAssets.kinRelationship,
                          showOuterTile: true,
                          controller: null,
                          obscureText: false,
                          initialValue: data.relationship,
                          readOnly: data.lastName.isNotBlank,
                        );
                      } else {
                        return const NextOfKinDropdown();
                      }
                    },
                    orElse: () => const NextOfKinDropdown(),
                  ),
              ref.watch(getNextOfKinFutureProvider).maybeWhen(
                    data: (data) {
                      if (data.emailAddress.isNotBlank) {
                        return RexTextField(
                          outerTitle: StringAssets.kinEmailAddress,
                          showOuterTile: true,
                          controller: provider.addressController,
                          obscureText: false,
                          hintText: data.emailAddress,
                          readOnly: data.emailAddress.isNotBlank,
                          validator: (value) => TextfieldValidator.email(value),
                          inputType: TextInputType.emailAddress,
                        );
                      }
                      return RexTextField(
                        outerTitle: StringAssets.kinEmailAddress,
                        showOuterTile: true,
                        hintText: StringAssets.addressHint,
                        controller: provider.addressController,
                        obscureText: false,
                        validator: (value) => TextfieldValidator.email(value),
                        inputType: TextInputType.emailAddress,
                      );
                    },
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.kinEmailAddress,
                      showOuterTile: true,
                      hintText: StringAssets.addressHint,
                      controller: provider.addressController,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.email(value),
                      inputType: TextInputType.emailAddress,
                    ),
                  ),
              ref.watch(getNextOfKinFutureProvider).maybeWhen(
                    data: (data) {
                      if (data.mobileNo.isNotBlank) {
                        return RexTextField(
                          outerTitle: StringAssets.kinPhoneNumber,
                          showOuterTile: true,
                          controller: provider.phoneController,
                          obscureText: false,
                          hintText: data.mobileNo,
                          readOnly: data.mobileNo.isNotBlank,
                          validator: (value) =>
                              TextfieldValidator.phoneNumber(value),
                          inputType: TextInputType.phone,
                        );
                      }
                      return RexTextField(
                        outerTitle: StringAssets.kinPhoneNumber,
                        showOuterTile: true,
                        hintText: StringAssets.phoneNumberHint,
                        controller: provider.phoneController,
                        obscureText: false,
                        validator: (value) =>
                            TextfieldValidator.phoneNumber(value),
                        inputType: TextInputType.phone,
                      );
                    },
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.kinPhoneNumber,
                      showOuterTile: true,
                      hintText: StringAssets.phoneNumberHint,
                      controller: provider.phoneController,
                      obscureText: false,
                      validator: (value) =>
                          TextfieldValidator.phoneNumber(value),
                      inputType: TextInputType.phone,
                    ),
                  ),
              const NextOfKinBirthDate(),
              SizedBox(height: 32.ah),
              showNOKSubmitButton(context)
            ],
          ),
        ),
        ref.watch(getNextOfKinFutureProvider).maybeWhen(
            data: (data) => Container(),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            orElse: () => Container()),
      ]),
    );
  }

  Widget showNOKSubmitButton(BuildContext context) {
    return ref.watch(getNextOfKinFutureProvider).maybeWhen(
          data: (data) {
            if (data != GetNextOfKinData.empty()) {
              return Container();
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.aw),
                child: RexElevatedButton(
                  onPressed: () => ref
                      .watch(nextOfKinNotifier.notifier)
                      .performNextOfKinUpdate(context),
                  buttonTitle: StringAssets.saveTextOnButton,
                  backgroundColor: null,
                ),
              );
            }
          },
          orElse: () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.aw),
            child: RexElevatedButton(
              onPressed: () => ref
                  .watch(nextOfKinNotifier.notifier)
                  .performNextOfKinUpdate(context),
              buttonTitle: StringAssets.saveTextOnButton,
              backgroundColor: null,
            ),
          ),
        );
  }
}
