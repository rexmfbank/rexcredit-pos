import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/get_profile_info_api_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

import '../../../../../../config/routes/route_name.dart';
import '../../../../../../config/theme/app_colors.dart';
import '../../../../../../utils/constants/string_assets.dart';
import '../../../../../individual/more/profile/ui/screens/personal_profile_screen.dart';
import '../../../../../shared/customer_tier/customer_profile_tier.dart';

class BusinessProfileInfoScreen extends ConsumerWidget {
  const BusinessProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(fetchProfileInformationProvider);
    return profileData.when(
      data: (data) {
        return ListView(
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
                child: Column(
                  children: [
                    BusinessLogoWidget(
                        imageUrl: data!.business?.businessLogo ?? ''),
                    SizedBox(height: 16.ah),
                    ProfileText(
                      title: StringAssets.businessNameTitle,
                      value: data.business!.businessName ?? '',
                    ),
                    ProfileText(
                      title: StringAssets.emailAddressTitle,
                      value: data.business!.businessEmail ?? '',
                    ),
                    ProfileText(
                      title: StringAssets.phoneNumberTitle,
                      value: data.business!.businessMobileNo ?? '',
                    ),
                    ProfileText(
                      title: StringAssets.businessRegistrationTitle,
                      value: data.business!.businessCode ?? 'N/A',
                    ),
                    ProfileText(
                      title: StringAssets.businessTypeTitle,
                      value: data.business!.businessType ?? 'N/A',
                    ),
                    ProfileText(
                      title: StringAssets.businessAddressTitle,
                      value: data.business!.businessAddress ?? 'N/A',
                    ),
                    ProfileText(
                      title: StringAssets.lga,
                      value: data.business!.lga ?? 'N/A',
                    ),
                    ProfileText(
                      title: StringAssets.state,
                      value: data.business!.state ?? 'N/A',
                    ),
                    ProfileText(
                      title: StringAssets.industry,
                      value: data.business!.businessSector ?? 'N/A',
                    ),
                    const CustomerProfileTier(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexElevatedButton(
                onPressed: () {
                  context.push(
                    "${Routes.dashboardMoreBusiness}/${Routes.editBusinessInfo}",
                  );
                },
                buttonTitle: StringAssets.editBusinessInfo,
                backgroundColor: null,
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (Object error, StackTrace stackTrace) => const Center(
        child: Text(
          StringAssets.personalInfoScreenError,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class BusinessLogoWidget extends StatelessWidget {
  final String imageUrl;

  const BusinessLogoWidget({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 120.0.aw,
        height: 120.0.ah,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(
            color: AppColors.rexLightBlue,
            width: 4.0.ar,
          ),
        ),
        child: Image.network(
          imageUrl,
          width: 50.0.aw,
          height: 50.0.ah,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: 100.ar,
            );
          },
        ),
      ),
    );
  }
}
