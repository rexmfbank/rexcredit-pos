import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/model/account_type_enum.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/provider/select_account_type_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/select_account_type/ui/account_type_tile.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AccountTypeSelectionScreen extends ConsumerStatefulWidget {
  const AccountTypeSelectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountTypeSelectionScreenState();
}

class _AccountTypeSelectionScreenState
    extends ConsumerState<AccountTypeSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: const RexAppBar(
          shouldHaveBackButton: false,
          title: StringAssets.accountType,
          subtitle: StringAssets.accountTypeSubtitle,
          step: '',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.aw),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: accountTypeList2.length,
                  itemBuilder: (context, index) {
                    return AccountTypeTile(
                      isChecked: accountTypeList2[index].isSelected,
                      title: accountTypeList2[index].title,
                      subtitle: accountTypeList2[index].subtitle,
                      imagePath: accountTypeList2[index].imagePath,
                      kycText: accountTypeList2[index].kycText,
                      onChanged: (newValue) {
                        setState(() {
                          for (var element in accountTypeList2) {
                            element.isSelected = false;
                          }
                          accountTypeList2[index].isSelected = newValue!;
                          ref
                              .read(selectAccountTypeProvider.notifier)
                              .setAccountType(accountTypeList2[index]);
                        });
                      },
                    );
                  },
                ),
              ),
              RexElevatedButton(
                onPressed: () {
                  ref
                      .read(selectAccountTypeProvider.notifier)
                      .validateSelection(context);
                },
                buttonTitle: StringAssets.continueTextOnButton,
                backgroundColor: AppColors.rexPurpleLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
