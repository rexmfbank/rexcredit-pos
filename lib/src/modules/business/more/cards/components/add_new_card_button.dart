import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AddNewCardButton extends ConsumerWidget{
  const AddNewCardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: ()=> ref.watch(cardNotifier.notifier).navigateToRequest(context),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.ah, horizontal: 5.aw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.ar),
          border: Border.all(
            width: 0.5.aw,
            color: AppColors.rexRedDark,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.add,
              size: 18.ar,
              color: AppColors.rexRedDark,
            ),
            SizedBox(width: 4.aw),
            Text(
              StringAssets.newDebitCard,
              style: AppTextStyles.body3Regular.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.rexRedDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

}