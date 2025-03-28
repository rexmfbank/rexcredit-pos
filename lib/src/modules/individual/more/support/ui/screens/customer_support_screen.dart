import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/individual/more/support/providers/support_future_provider.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';
import 'package:rex_app/src/utils/launcher_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerSupportScreen extends HookConsumerWidget {
  const CustomerSupportScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  openWhatsApp(String phone) {
    if (Platform.isAndroid) {
      //'https://wa.me/1234567890' //you use this url also
      return launchUrl(Uri.parse('whatsapp://send?phone=$phone'));
    } else {
      final digit = phone.formatWhatsAppDigit();
      return launchUrl(Uri.parse("whatsapp://send?phone=$digit"));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactCareData = ref.watch(supportFutureProvider2);
    final isBusiness = ref.watch(userIsBusinessProvider);
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: '',
        title: StringAssets.supportT1,
        subtitle: StringAssets.supportT2,
      ),
      body: contactCareData.when(
        data: (data) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              RexListTile(
                leadingWidget: Image.asset(AssetPath.moreProfileIcon),
                title: StringAssets.supportT3,
                subtitle: StringAssets.supportT4,
                hasTrailingIcon: true,
                onTap: () {
                  //openWhatsApp(data.whatsAppNo);
                  if (isBusiness) {
                    context.push(
                        "${RouteName.dashboardMoreBusiness}/${RouteName.bizChatScreen}");
                  } else {
                    context.push(
                        "${RouteName.dashboardMore}/${RouteName.indChatScreen}");
                  }
                },
              ),
              RexListTile(
                leadingWidget: Image.asset(AssetPath.supportEmailUsIcon),
                title: StringAssets.supportT5,
                subtitle: data.email,
                hasTrailingIcon: true,
                onTap: () {
                  LauncherUtils().sendEmail(data.email);
                },
              ),
              RexListTile(
                leadingWidget: Image.asset(AssetPath.moreSupportIcon),
                title: StringAssets.supportT6,
                subtitle: data.phoneNo,
                hasTrailingIcon: true,
                onTap: () async {
                  _makePhoneCall(data.phoneNo);
                },
              ),
              RexListTile(
                leadingWidget: Image.asset(AssetPath.moreQuestionIcon),
                title: StringAssets.disputesTitle,
                subtitle: StringAssets.disputesSubtitle,
                hasTrailingIcon: true,
                onTap: () {
                  context.push(
                      "${RouteName.dashboardMore}/${RouteName.individualDisputes}");
                },
              ),
            ],
          );
        },
        error: (error, stack) {
          return Center(
            child: Text(
              StringAssets.supportT7,
              style: AppTextStyles.h3,
            ),
          );
        },
        loading: () {
          return Center(
            child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
