import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/more/provider/more_provider.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/profile_screen_avatar.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/profile_slide.dart';
import 'package:rex_app/src/modules/individual/more/profile/ui/components/security_slide.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/page_view_text_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: 0);
    final pageIndex = ref.watch(profilePageViewIndexProvider);
    final profileData = ref.watch(loginProvider);
    //
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.profileScreenTitle,
        subtitle: StringAssets.profileScreenSubtitle,
        step: StringAssets.emptyString,
        onBackButtonPressed: () {
          context.go(Routes.dashboardMore);
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.ah),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.aw),
              child: profileData.loginResponse.when(
                data: (data) {
                  return ProfileScreenAvatar(
                    name: data?.data.fullname ?? "Unknown User",
                    accountNumber:
                        (data != null && data.data.primaryAccountNo.isNotBlank)
                            ? data.data.primaryAccountNo!
                            : 'xxxx-xxxx-xxxx',
                    imageUrl: data?.data.photoLinks ?? '',
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => const Text('Error'),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageViewTextButton(
                      textOnButton: StringAssets.profileTextOnButton,
                      pageController: pageController,
                      backgroundColor:
                          pageIndex == 0 ? AppColors.rexWhite : null,
                      shape: pageIndex == 0 ? roundRectBorder : null,
                      onPressed: () {
                        pageController.previousPage(
                          duration: duration300ms,
                          curve: easeInCurve,
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: PageViewTextButton(
                      textOnButton: StringAssets.securityTextOnButton,
                      pageController: pageController,
                      backgroundColor:
                          pageIndex == 1 ? AppColors.rexWhite : null,
                      shape: pageIndex == 1 ? roundRectBorder : null,
                      onPressed: () {
                        pageController.nextPage(
                          duration: duration300ms,
                          curve: easeInCurve,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (int value) {
                  ref.read(profilePageViewIndexProvider.notifier).state = value;
                },
                children: const [
                  ProfileSlide(),
                  SecuritySlide(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
