import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/pin_input_field.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class CardOtpScreen extends ConsumerStatefulWidget {
  final VoidCallback onComplete;
  const CardOtpScreen({super.key, required this.onComplete});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardOtpScreenState();
}

class _CardOtpScreenState extends ConsumerState<CardOtpScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.watch(cardNotifier.notifier).disposeCardOTPController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.rexBackgroundGrey,
        leading: BackButton(
          color: AppColors.rexPurpleDark,
          onPressed: context.pop,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 90.ah),
          SvgPicture.asset(
            AssetPath.otpLockIcon,
            height: 124.ah,
          ),
          SizedBox(height: 24.ah),
          Text(
            StringAssets.cardOtpPrompt,
            textAlign: TextAlign.center,
            style: AppTextStyles.body2Regular.copyWith(
              color: AppColors.textGreyLight,
              height: 1.6,
            ),
          ),
          SizedBox(height: 52.ah),
          PinInputField(
            controller: ref.watch(cardNotifier).cardOtpController,
            focusNode: ref.watch(cardNotifier).cardOtpFocusNode,
            validationError: ValueNotifier(ref.watch(cardNotifier).cardOtpValidation),
            key: ref.watch(cardNotifier).cardOtpKey,
            onTap: () => ref.watch(cardNotifier.notifier).onCardOtpTap(),
            length: 6,
            onEditingComplete: (pin) {
              ref.watch(cardNotifier.notifier).cardOTPValidator();
            },
            onComplete: widget.onComplete,
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: widget.onComplete,
            buttonTitle: StringAssets.verify,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
