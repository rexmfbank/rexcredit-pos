import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/screens/business_profile_screen.dart';
import 'package:rex_app/src/modules/individual/more/profile/providers/get_profile_info_api_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessInfoScreen extends ConsumerWidget {
  const BusinessInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final businessInfoData = ref.watch(fetchProfileInformationProvider);
    //
    return AppScaffold(
      backgroundColor: AppColors.rexBackgroundGrey,
      padding: EdgeInsets.zero,
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.businessInfoTitle,
        subtitle: StringAssets.businessInfoSubtitle,
      ),
      body: businessInfoData.when(
        data: (data) => data?.business != null
            ? const BusinessProfileInfoScreen()
            : const Center(
                child: Text(
                StringAssets.businessInfoScreenError,
                textAlign: TextAlign.center,
              )),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (Object error, StackTrace stackTrace) => const Center(
          child: Text(
            StringAssets.businessInfoScreenError,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
