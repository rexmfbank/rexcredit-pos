import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

void showModalLoanOffer({
  required BuildContext context,
  required void Function()? onPressed,
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
        height: 650,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Offer letter',
                    style: TextStyle(
                      color: AppColors.rexPurpleDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: AppColors.cardBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(14.0),
              margin: const EdgeInsets.only(left: 14.0, right: 14.0),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(StringAssets.offerLetter1),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}
