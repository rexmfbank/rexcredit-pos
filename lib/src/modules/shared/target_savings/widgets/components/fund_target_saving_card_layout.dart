import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/add_new_card_button.dart';
import 'package:rex_app/src/modules/shared/target_savings/providers/target_saving_notifier.dart';
import 'package:rex_app/src/modules/shared/target_savings/widgets/components/fund_saving_card_tile.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';

class FundTargetSavingCardLayout extends ConsumerWidget {
  const FundTargetSavingCardLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createSaving = ref.watch(targetSavingProvider);
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
              'Saved Cards',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: createSaving.cardListResponse.when(
              data: (cardListResponse) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: cardListResponse!.data.length,
                  itemBuilder: (context, index) {
                    if (cardListResponse.data.isEmpty) {
                      return const _SavedCardText(
                        text: 'No saved cards available. Add one.',
                      );
                    }
                    return FundSavingCardTitle(
                      debitCardData: cardListResponse.data[index],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return const _SavedCardText(
                  text: 'We are unable to get your saved card(s).',
                );
              },
              loading: () => const _SavedCardText(text: 'Getting cards.'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: AddNewCardButton(
              onPressed: () {
                ref.read(targetSavingProvider.notifier).addNewCard(context);
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
