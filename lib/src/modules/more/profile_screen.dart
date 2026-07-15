import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/provider/login_provider.dart';
import 'package:rex_app/src/modules/more/widgets/profile_slide.dart';
import 'package:rex_app/src/modules/more/widgets/security_slide.dart';
import 'package:rex_app/src/modules/quick_purchase/ui_widgets/rex_app_bar.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/page_view_text_button.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController(initialPage: 0);
    final pageIndex = ref.watch(profilePageViewIndexProvider);
    // final profileData = ref.watch(loginProvider);
    //
    return Scaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: Strings.profileScreenTitle,
        subtitle: Strings.profileScreenSubtitle,
        step: Strings.emptyString,
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
              child: const Text('profile-data'),
              /*child: profileData.loginResponse.when(
                data: (data) {
                  return ProfileScreenAvatar(
                    name: data?.data.fullname ?? "Unknown User",
                    accountNumber:
                        (data != null && data.data.primaryAccountNo!.isNotBlank)
                            ? data.data.primaryAccountNo!
                            : 'xxxx-xxxx-xxxx',
                    imageUrl: data?.data.photoLinks ?? '',
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => const Text('Error'),
              ),*/
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PageViewTextButton(
                      textOnButton: Strings.profileTextOnButton,
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
                      textOnButton: Strings.securityTextOnButton,
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
                children: const [ProfileSlide(), SecuritySlide()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
