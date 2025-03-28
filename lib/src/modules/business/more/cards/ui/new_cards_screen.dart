import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/components/add_new_card_button.dart';
import 'package:rex_app/src/modules/business/more/cards/components/rex_card_tile.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class NewCardsScreen extends ConsumerStatefulWidget {
  const NewCardsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewCardsScreenState();
}

class _NewCardsScreenState extends ConsumerState<NewCardsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cardNotifier.notifier).getCards(context);
      ref.read(cardNotifier.notifier).getCardProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.myCards,
        subtitle: StringAssets.tapOnCardDetails,
        suffixWidget: ref.watch(cardNotifier).cards.isNotEmpty
            ? const SizedBox.shrink()
            : const AddNewCardButton(),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            ref.watch(cardNotifier.notifier).getCards(context),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(height: 20.ah),
            ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return RexCardTile(
                  card: ref.watch(cardNotifier).cards[index],
                  onTap: () {
                    ref.watch(cardNotifier.notifier).navigateToCardOptions(
                          context: context,
                          model: ref.watch(cardNotifier).cards[index],
                        );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: ref.watch(cardNotifier).cards.length,
            ),
          ],
        ),
      ),
    );
  }
}
