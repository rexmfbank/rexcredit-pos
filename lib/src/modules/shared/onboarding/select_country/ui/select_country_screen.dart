import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/login/ui/components/app_version_text.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/provider/app_country_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/provider/select_country_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/ui/components/country_tile.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/ui/components/country_tile_disabled.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/ui/components/select_country_appbar_title.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_country/ui/components/select_country_login_text.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/service/secure_storage.dart';

class SelectCountryScreen extends ConsumerStatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectCountryScreenState();
}

class _SelectCountryScreenState extends ConsumerState<SelectCountryScreen> {
  @override
  void initState() {
    super.initState();
    SecureStorage().setLaunchStateVal('FL');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(appCountryProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.rexBackground,
        title: const SelectCountryAppBarTitle(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.aw),
        child: Column(
          children: [
            SizedBox(height: 8.ah),
            ref.watch(appCountryProvider).when(
                  data: (countries) {
                    return SizedBox(
                      height: 200.ah,
                      child: ListView.builder(
                        itemCount: countries.length,
                        itemBuilder: (context, index) {
                          return CountryTile(
                            countryTitle: countries[index].name,
                            countryUrl: countries[index].url ?? '',
                            value: countries[index].isSelected,
                            onChanged: (newValue) {
                              setState(() {
                                for (var element in countries) {
                                  element.isSelected = false;
                                }
                                countries[index].isSelected = newValue!;
                                ref
                                    .read(selectCountryProvider.notifier)
                                    .setCountry(countries[index]);
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                  error: (error, stackTrace) => const CountryTileDisabled(),
                  loading: () => const CountryTileDisabled(),
                ),
            SizedBox(height: 14.ah),
            RexElevatedButton(
              onPressed: () => ref
                  .read(selectCountryProvider.notifier)
                  .validateSelection(context),
              buttonTitle: StringAssets.nextTextOnButton,
              backgroundColor: AppColors.rexPurpleLight,
            ),
            const SelectCountryLoginText(),
          ],
        ),
      ),
      bottomSheet: Container(
        color: AppColors.rexBackground,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppVersionText(),
            SizedBox(height: 30.ah),
          ],
        ),
      ),
    );
  }
}
