import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/login/providers/login_provider.dart';
import 'package:rex_app/src/modules/shared/models/dashboard/dashboard_model.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

final dashboardProvider =
    AutoDisposeNotifierProvider<DashboardNotifier, DashboardModel>(
        () => DashboardNotifier());

class DashboardNotifier extends AutoDisposeNotifier<DashboardModel> {
  @override
  DashboardModel build() => DashboardModel();

  void checkPasswordChange(BuildContext context) {
    if (ref.read(loginProvider).loginResponse.value?.data.forcePwdChange ==
        'Y') {
      if (ref.read(userIsBusinessProvider)) {
        context
            .push("${Routes.dashboardMoreBusiness}/${Routes.changepassword}");
        return;
      }
      context.push('${Routes.dashboardMore}/${Routes.changepassword}');
    }
  }

  void checkKycPending(BuildContext context) {
    final login = ref.watch(loginProvider);
    if (login.loginResponse.value?.data.pendingKycDocument != null &&
        login.loginResponse.value!.data.pendingKycDocument!) {
      showModalAction(
        context: context,
        useDoubleButton: true,
        lottieAnimation: LottieBuilder.asset(LottieAsset.loginAnimation),
        dialogTitle: StringAssets.hiThere,
        dialogSubtitle: StringAssets.youHaveKycPending,
        doubleButtonTitle1: StringAssets.proceed,
        doubleButtonTitle2: StringAssets.cancel,
        doubleButton1Tap: () {
          context.pop();
          if (ref.read(userIsBusinessProvider)) {
            context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.businessKycDocuments}");
            return;
          }
          context.push('${Routes.dashboardMore}/${Routes.updateAccount}');
        },
        doubleButton2Tap: () => context.pop(),
      );
    }
  }
}
