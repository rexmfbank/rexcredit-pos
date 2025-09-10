import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/more/profile/providers/get_profile_info_api_provider.dart';
import 'package:rex_app/src/modules/more/profile/providers/personal_info_screen_provider.dart';
import 'package:rex_app/src/modules/more/profile/providers/update_user_personal_info_provider.dart';
import 'package:rex_app/src/modules/more/ui/components/personal_info_display_picture.dart';
import 'package:rex_app/src/modules/more/ui/components/personal_info_take_picture.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

import '../../../../revamp/utils/routes/route_name.dart';
import '../../../../revamp/utils/theme/app_colors.dart';
import '../../../../shared/widgets/rex_custom_text_field.dart';
import '../../../../shared/widgets/rex_flat_button.dart';

class PersonalInfoScreen extends StatefulHookConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PersonalInfoScreen();
}

class _PersonalInfoScreen extends ConsumerState<PersonalInfoScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getProfileInfoProvider.notifier).getProfileInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final profileData = ref.watch(getProfileInfoProvider);
    //
    return AppScaffold(
      isLoading: ref.watch(updatePersonalInfoProvider).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: StringAssets.emptyString,
        title: StringAssets.personalInfoTitle,
        subtitle: StringAssets.personalInfoSubtitle,
      ),
      body: Stack(children: [
        Form(
          key: ref.watch(personalInfoScreenNotifier).formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              profileData.maybeWhen(
                data: (data) {
                  debugPrint("Personal Info Data: $data");
                  debugPrint("Photo Link: ${data.photoLink}");
                  if (data.photoLink != null) {
                    debugPrint("data.photoLink");
                    return PersonalInfoDisplayPicture(
                      imageUrl: data.photoLink,
                    );
                  }
                  return const PersonalInfoPicture();
                },
                orElse: () => const PersonalInfoPicture(),
              ),
              profileData.maybeWhen(
                data: (data) {
                  return RexTextField(
                    outerTitle: StringAssets.firstNameTitle,
                    showOuterTile: true,
                    hintText: data.firstname,
                    controller: null,
                    obscureText: false,
                    initialValue: data.firstname,
                    readOnly: true,
                    backgroundColor: AppColors.grey2,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.firstNameTitle,
                  showOuterTile: true,
                  hintText: StringAssets.firstNameHint,
                  controller: firstNameController,
                  obscureText: false,
                  backgroundColor: AppColors.grey2,
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  if (data.middlename.isNotBlank) {
                    return RexTextField(
                      outerTitle: StringAssets.middleNameTitle,
                      showOuterTile: true,
                      hintText: data.middlename,
                      readOnly: true,
                      controller: ref
                          .watch(personalInfoScreenNotifier)
                          .middleNameController,
                      obscureText: false,
                      backgroundColor: AppColors.grey2,
                    );
                  }
                  return RexTextField(
                    outerTitle: StringAssets.middleNameTitle,
                    showOuterTile: true,
                    hintText: StringAssets.middleNameHint,
                    controller: ref
                        .watch(personalInfoScreenNotifier)
                        .middleNameController,
                    obscureText: false,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.middleNameTitle,
                  showOuterTile: true,
                  hintText: StringAssets.middleNameHint,
                  controller: ref
                      .watch(personalInfoScreenNotifier)
                      .middleNameController,
                  obscureText: false,
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  final names = data.fullname!.split(" ");
                  return RexTextField(
                    outerTitle: StringAssets.lastNameTitle,
                    showOuterTile: true,
                    controller: null,
                    obscureText: false,
                    hintText: names.last,
                    readOnly: true,
                    backgroundColor: AppColors.grey2,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.lastNameTitle,
                  showOuterTile: true,
                  hintText: StringAssets.lastNameHint,
                  controller: lastNameController,
                  obscureText: false,
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  return RexTextField(
                    outerTitle: StringAssets.emailAddressTitle,
                    showOuterTile: true,
                    hintText: data.email,
                    controller: null,
                    obscureText: false,
                    initialValue: data.email,
                    readOnly: true,
                    backgroundColor: AppColors.grey2,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.emailAddressTitle,
                  showOuterTile: true,
                  hintText: StringAssets.emailAddressHint,
                  controller: lastNameController,
                  obscureText: false,
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  return RexTextField(
                    outerTitle: StringAssets.phoneNumberTitle,
                    showOuterTile: true,
                    hintText: "+${data.mobileNo}",
                    controller: null,
                    obscureText: false,
                    initialValue: "+${data.mobileNo}",
                    readOnly: true,
                    backgroundColor: AppColors.grey2,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.phoneNumberTitle,
                  showOuterTile: true,
                  hintText: StringAssets.phoneNumberHint,
                  controller: lastNameController,
                  obscureText: false,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                    child: Text(
                      StringAssets.dateOfBirthTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.0,
                        color: AppColors.rexPurpleDark,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate:
                            DateTime.fromMillisecondsSinceEpoch(1640979000000),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2024),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            this.selectedDate = selectedDate;
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: profileData.maybeWhen(
                        data: (data) {
                          return Text(
                            data.dob?.formatDateString() ?? '',
                            style: const TextStyle(
                              color: AppColors.rexTint500,
                            ),
                          );
                        },
                        orElse: () => Text(
                          selectedDate != null
                              ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
                              : StringAssets.selectDate,
                          style: const TextStyle(
                            color: AppColors.rexTint500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              profileData.maybeWhen(
                data: (data) {
                  return RexTextField(
                    outerTitle: StringAssets.gender,
                    showOuterTile: true,
                    controller: null,
                    obscureText: false,
                    hintText: data.gender,
                    readOnly: true,
                    backgroundColor: AppColors.grey2,
                  );
                },
                orElse: () => RexTextField(
                  outerTitle: StringAssets.gender,
                  showOuterTile: true,
                  controller: firstNameController,
                  obscureText: false,
                  backgroundColor: AppColors.grey2,
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  return RexCustomTextField(
                    outerTitle: StringAssets.residentAddressTitle,
                    obscureText: false,
                    hintText: data.address,
                    readOnly: true,
                    onTap: () => context.go(
                        "${Routes.dashboardMore}/${Routes.editResidentialAddress}"),
                  );
                },
                orElse: () => RexCustomTextField(
                  outerTitle: StringAssets.residentAddressTitle,
                  obscureText: false,
                  hintText: StringAssets.addressHint2,
                  readOnly: true,
                  onTap: () => context.go(
                      "${Routes.dashboardMore}/${Routes.editResidentialAddress}"),
                ),
              ),
              profileData.maybeWhen(
                data: (data) {
                  if (data.middlename.isNotBlank) {
                    return const SizedBox(
                      height: 100,
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RexFlatButton(
                      onPressed: () {
                        ref
                            .read(personalInfoScreenNotifier.notifier)
                            .performPersonalInfoUpdate(context);
                      },
                      buttonTitle: StringAssets.updateButtonTitle,
                      backgroundColor: AppColors.rexPurpleLight,
                    ),
                  );
                },
                orElse: () => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RexFlatButton(
                    onPressed: () {
                      ref
                          .read(personalInfoScreenNotifier.notifier)
                          .performPersonalInfoUpdate(context);
                    },
                    buttonTitle: StringAssets.updateButtonTitle,
                    backgroundColor: AppColors.rexPurpleLight,
                  ),
                ),
              ),
            ],
          ),
        ),
        profileData.when(
          data: (data) => Container(),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) =>
              const Text(StringAssets.profileInfoError),
        ),
      ]),
    );
  }
}
