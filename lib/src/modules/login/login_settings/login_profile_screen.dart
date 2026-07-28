import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_settings/widgets/settings_profile_widgets.dart';
import 'package:rex_app/src/modules/more/provider/profile_provider.dart';
import 'package:rex_app/src/modules/utils/general/app_keys.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/utils/widgets/appbar_sub_screen.dart';

class LoginProfileScreen extends ConsumerStatefulWidget {
  const LoginProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginProfileScreenState();
}

class _LoginProfileScreenState extends ConsumerState<LoginProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);
    final config = AppKeysStorage.getConfig();
    //
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.zero,
      appBar: AppbarSubScreen(title: 'Personal Information', centerTitle: true),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Color(0xffF1F5FF),
            margin: EdgeInsets.only(left: 8, right: 8.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        config.loginFullname,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(config.loginNuban),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 8.ah),
          Card(
            color: Color(0xffF1F5FF),
            margin: EdgeInsets.only(left: 8, right: 8.0, top: 8.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
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
                    () => Center(child: CupertinoActivityIndicator(radius: 20)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
