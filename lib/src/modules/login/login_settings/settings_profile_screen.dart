import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_settings/widgets/settings_profile_widgets.dart';
import 'package:rex_app/src/modules/more/provider/profile_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class SettingsProfileScreen extends ConsumerStatefulWidget {
  const SettingsProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends ConsumerState<SettingsProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.zero,
      appBar: AppbarSubScreen(title: 'Personal Information', centerTitle: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: 16.ah),
          Card(
            margin: EdgeInsets.all(16.0.ar),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0.ar),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0.ah),
              child: state.when(
                data: (data) {
                  if (data.profiles.isEmpty) {
                    return Center(child: Text("No profile data found"));
                  }
                  return Column(
                    children: [
                      //ProfileImageWidget(imageUrl: ''),
                      SizedBox(height: 16.ah),
                      ProfileText(
                        title: Strings.firstNameTitle,
                        value: data.profiles[0].borrower?.firstName ?? 'n/a',
                      ),
                      ProfileText(
                        title: Strings.lastNameTitle,
                        value: data.profiles[0].borrower?.lastName ?? 'n/a',
                      ),
                      ProfileText(
                        title: Strings.emailAddressTitle,
                        value: data.profiles[0].borrower?.email ?? 'n/a',
                      ),
                      ProfileText(
                        title: Strings.phoneNumberTitle,
                        value: data.profiles[0].borrower?.phone ?? 'n/a',
                      ),
                      //ProfileText(title: Strings.dateOfBirthTitle, value: ""),
                      ProfileText(
                        title: Strings.gender,
                        value: data.profiles[0].borrower?.gender ?? 'n/a',
                      ),
                      ProfileText(
                        title: Strings.addressTitle,
                        value: data.profiles[0].borrower?.address ?? 'n/a',
                      ),
                      ProfileText(
                        title: 'Account Tier',
                        value: "TIER ${data.profiles[0].borrower?.kycTier}",
                      ),
                      //const CustomerProfileTier(),
                    ],
                  );
                },
                error: (_, _) => Center(child: Text('Could not fetch profile')),
                loading:
                    () => Center(
                      child: CircularProgressIndicator(
                        color: AppColors.rexBlue,
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
