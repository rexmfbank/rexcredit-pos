import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/business/more/profile/components/business_profile_custom_titled_switch_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessSetupBiometricScreen extends ConsumerWidget {
  const BusinessSetupBiometricScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.setUpBio,
        subtitle: StringAssets.verifyBiometric,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          CustomTitledSwitchWidget(
            initialValue: false,
            title: StringAssets.loginWithFingerprint,
            subtitle: StringAssets.verifyYourFingerprint,
            onChanged: (value) {},
          ),
          Visibility(
            visible: false,
            child: CustomTitledSwitchWidget(
              title: StringAssets.paymentsWithFingerprint,
              subtitle: StringAssets.verifyPaymentsWithFingerprint,
              onChanged: (value) {
                // Do something with the switch value outside the widget
                if (value) {
                  // Switch is turned on
                  // Perform an action
                } else {
                  // Switch is turned off
                  // Perform a different action
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
