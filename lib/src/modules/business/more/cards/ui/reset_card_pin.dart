import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ResetCardPin extends ConsumerWidget {
  const ResetCardPin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: const CustomAppBar(
        title: StringAssets.resetPin,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.ah),
          Text(
            StringAssets.currentPin,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.enterCurrentPin,
            controller: ref.watch(cardNotifier).cardPasswordController,
            backgroundColor: AppColors.rexWhite,
            obscureText: ref.watch(cardNotifier).obscureCurrentPassword,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.pin(value),
            suffixIcon: InkWell(
              onTap: () =>
                  ref.watch(cardNotifier.notifier).toggleResetCurrentPin(),
              child: Icon(
                ref.watch(cardNotifier).obscureCurrentPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18.ar,
                color: ref.watch(cardNotifier).obscureCurrentPassword
                    ? AppColors.rexPurpleLight
                    : AppColors.rexTint500,
              ),
            ),
          ),
          SizedBox(height: 16.ah),
          Text(
            StringAssets.newPin,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.enterNewPin,
            controller: ref.watch(cardNotifier).cardNewPasswordController,
            backgroundColor: AppColors.rexWhite,
            obscureText: ref.watch(cardNotifier).obscureNewPassword,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.pin(value),
            suffixIcon: InkWell(
              onTap: () => ref.watch(cardNotifier.notifier).toggleResetNewPin(),
              child: Icon(
                ref.watch(cardNotifier).obscureNewPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18.ar,
                color: ref.watch(cardNotifier).obscureNewPassword
                    ? AppColors.rexPurpleLight
                    : AppColors.rexTint500,
              ),
            ),
          ),
          SizedBox(height: 16.ah),
          Text(
            StringAssets.confirmNewPin,
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 7.ah),
          RexTextField(
            horizontalPadding: 0,
            showOuterTile: false,
            hintText: StringAssets.reenterNewPin,
            controller: ref.watch(cardNotifier).cardConfirmPasswordController,
            backgroundColor: AppColors.rexWhite,
            obscureText: ref.watch(cardNotifier).obscureConfirmPassword,
            inputType: TextInputType.number,
            validator: (value) => TextfieldValidator.pin(value),
            maxLines: 1,
            suffixIcon: InkWell(
              onTap: () =>
                  ref.watch(cardNotifier.notifier).toggleResetConfirmPin(),
              child: Icon(
                ref.watch(cardNotifier).obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18.ar,
                color: ref.watch(cardNotifier).obscureConfirmPassword
                    ? AppColors.rexPurpleLight
                    : AppColors.rexTint500,
              ),
            ),
          ),
          SizedBox(height: 50.ah),
          RexFlatButton(
            onPressed: () => ref
                .watch(cardNotifier.notifier)
                .performChangePinAction(context),
            buttonTitle: StringAssets.submitTextOnButton,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
