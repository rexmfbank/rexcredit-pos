import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: AppbarSubScreen(title: 'Personal Information'),
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

class ProfileText extends StatelessWidget {
  final String title;
  final String value;
  final bool isEditable;

  const ProfileText({
    super.key,
    required this.title,
    required this.value,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.ah, horizontal: 24.0.aw),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(color: AppColors.rexPurpleLight),
            ),
          ),
          SizedBox(width: 10.aw),
          Expanded(
            flex: isEditable ? 2 : 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
              overflow: TextOverflow.visible,
            ),
          ),
          isEditable
              ? Expanded(
                flex: 1,
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit_square,
                      color: AppColors.rexPurpleDark3,
                    ),
                    onPressed: () {},
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProfileImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120.0.aw,
        height: 120.0.ah,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.rexLightBlue, width: 4.0.ar),
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            width: 50.0.aw,
            height: 50.0.ah,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.person, size: 100.ar);
            },
          ),
        ),
      ),
    );
  }
}
