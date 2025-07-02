import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/dashboard/providers/dashboard_topup_provider.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/add_new_card_button.dart';
import 'package:rex_app/src/modules/shared/dashboard/widgets/account_card/saved_card_tile.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardCardLayout extends ConsumerWidget {
  const DashboardCardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardTopUp = ref.watch(dashboardTopUpProvider);
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              StringAssets.fundSave2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: dashboardTopUp.cardListResponse.when(
              data: (cardListResponse) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.aw,
                    vertical: 10.ah,
                  ),
                  itemCount: cardListResponse!.data.length,
                  itemBuilder: (context, index) {
                    if (cardListResponse.data.isEmpty) {
                      return const _SavedCardText(
                        text: StringAssets.noSavedCardText,
                      );
                    }
                    return SavedCardTile(
                      debitCardData: cardListResponse.data[index],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return const _SavedCardText(
                  text: StringAssets.unableToSaveCardText,
                );
              },
              loading: () => const _SavedCardText(
                text: StringAssets.gettingCards,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AddNewCardButton(
              onPressed: () {
                ref.read(dashboardTopUpProvider.notifier).addNewCard(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedCardText extends StatelessWidget {
  const _SavedCardText({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        text,
        style: AppTextStyles.body1Regular,
      ),
    );
  }
}
