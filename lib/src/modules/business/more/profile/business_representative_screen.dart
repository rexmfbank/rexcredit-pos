import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/components/representative_birth_date.dart';
import 'package:rex_app/src/modules/business/more/profile/providers/business_representative_provider.dart';
import 'package:rex_app/src/modules/business/more/profile/providers/create_representative_api_provider.dart';
import 'package:rex_app/src/modules/business/more/profile/providers/fetch_representative_api_provider.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class BusinessRepresentativeScreen extends StatefulHookConsumerWidget {
  const BusinessRepresentativeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessRepresentativeScreen();
}

class _BusinessRepresentativeScreen
    extends ConsumerState<BusinessRepresentativeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(fetchRepresentativeApiProvider.notifier)
          .getBusinessRepresentative();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(businessRepresentativeScreenProvider);
    final businessRepresentativeData = ref.watch(getBusinessRepFutureProvider);

    //
    ref.listen(
      createRepresentativeApiProvider,
      (_, state) {
        state.when(
          data: (data) {
            LoadingScreen.instance().hide();
            showSuccessModal(
              context,
              StringAssets.businessRepAddedTitle,
              StringAssets.nokConfirmedSubtitle,
              StringAssets.ok,
              'success_tick',
              () {
                context.pop();
                context.pop();
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
    return AppScaffold(
      isLoading: ref.watch(fetchRepresentativeApiProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.businessRepresentativeTitle,
        subtitle: StringAssets.businessRepresentativeSubtitle,
      ),
      body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          children: [
            Form(
              key: provider.formKey,
              child: Column(
                children: [
                  businessRepresentativeData.maybeWhen(
                    data: (data) {
                      if (data.firstName.isNotBlank) {
                        return RexTextField(
                          outerTitle: StringAssets.firstNameTitle,
                          showOuterTile: true,
                          controller: provider.firstNameController,
                          obscureText: false,
                          hintText: data.firstName,
                          readOnly: data.firstName.isNotBlank,
                        );
                      }
                      return RexTextField(
                        outerTitle: StringAssets.firstNameRequiredTitle,
                        hintText: StringAssets.firstNameHint,
                        controller: provider.firstNameController,
                        showOuterTile: true,
                        obscureText: false,
                        validator: (value) => TextfieldValidator.name(value),
                      );
                    },
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.firstNameRequiredTitle,
                      hintText: StringAssets.firstNameHint,
                      controller: provider.firstNameController,
                      showOuterTile: true,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.name(value),
                    ),
                  ),
                  businessRepresentativeData.maybeWhen(
                    data: (data) => RexTextField(
                      outerTitle: StringAssets.middleNameTitle,
                      hintText: data.middleName,
                      controller: provider.middleNameController,
                      showOuterTile: true,
                      obscureText: false,
                      readOnly: true,
                    ),
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.middleNameTitle,
                      hintText: StringAssets.middleNameHint,
                      controller: provider.middleNameController,
                      showOuterTile: true,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.name(value),
                    ),
                  ),
                  businessRepresentativeData.maybeWhen(
                    data: (data) => RexTextField(
                      outerTitle: StringAssets.lastNameTitle,
                      hintText: data.lastName,
                      controller: provider.lastNameController,
                      showOuterTile: true,
                      obscureText: false,
                      readOnly: true,
                    ),
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.lastNameTitle,
                      hintText: StringAssets.lastNameHint,
                      controller: provider.lastNameController,
                      showOuterTile: true,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.name(value),
                    ),
                  ),
                  businessRepresentativeData.maybeWhen(
                    data: (data) => RexTextField(
                      outerTitle: StringAssets.dateOfBirthTitle,
                      initialValue: data.dateOfBirth,
                      hintText: data.dateOfBirth,
                      showOuterTile: true,
                      obscureText: false,
                      readOnly: true,
                    ),
                    orElse: () => const RepresentativeBirthDate(),
                  ),
                  businessRepresentativeData.maybeWhen(
                    data: (data) => RexTextField(
                      outerTitle: StringAssets.emailAddressTitle,
                      hintText: data.email,
                      controller: provider.emailController,
                      showOuterTile: true,
                      obscureText: false,
                      readOnly: true,
                    ),
                    orElse: () => RexTextField(
                      outerTitle: StringAssets.emailAddressTitle,
                      hintText: StringAssets.emailAddressHint,
                      controller: provider.emailController,
                      showOuterTile: true,
                      obscureText: false,
                      validator: (value) => TextfieldValidator.email(value),
                    ),
                  ),
                  businessRepresentativeData.maybeWhen(
                    data: (data) => Container(),
                    orElse: () => Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RexFlatButton(
                        onPressed: () {
                          ref
                              .watch(
                                  businessRepresentativeScreenProvider.notifier)
                              .createBusinessRepresentative(context);
                        },
                        buttonTitle: StringAssets.saveText,
                        backgroundColor: null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
