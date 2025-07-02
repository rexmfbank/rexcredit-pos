import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showModalDeclineLoan({
  required BuildContext context,
  required void Function()? onPressed,
  required TextEditingController textController,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: 400,
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      StringAssets.declineOfferTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.rexPurpleDark,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ),
            const Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Text(
                  "Please give a reason for declining this loan offer at this time.",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.rexTint500,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const DeclineLoanExplanationText(),
            const SizedBox(height: 16.0),
            RexTextField(
              outerTitle: 'Please select a reason for declining',
              hintText: '',
              controller: textController,
              backgroundColor: AppColors.rexBackground,
              obscureText: false,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: RexElevatedButton(
                onPressed: onPressed,
                buttonTitle: 'Yes, decline offer',
                backgroundColor: null,
              ),
            ),
          ],
        ),
      );
    },
  );
}

class DeclineLoanExplanationText extends StatelessWidget {
  const DeclineLoanExplanationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
      child: const Row(
        children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: AppColors.rexYellow,
              child: Icon(
                Icons.priority_high,
                color: AppColors.rexWhite,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Proceeding with this action means you are rejecting the loan offer provided.',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
