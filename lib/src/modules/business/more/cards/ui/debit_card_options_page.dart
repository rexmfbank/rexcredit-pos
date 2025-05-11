import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/data/rex_api/src/utils/enums/enums.dart';
import 'package:rex_app/src/modules/business/more/cards/components/card_options_tile.dart';
import 'package:rex_app/src/modules/business/more/cards/components/rex_card_tile.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DebitCardOptionsPage extends ConsumerStatefulWidget {
  final CardListDetails card;
  const DebitCardOptionsPage({super.key, required this.card});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DebitCardOptionsPageState();
}

class _DebitCardOptionsPageState extends ConsumerState<DebitCardOptionsPage> {
  @override
  void initState() {
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cardNotifier.notifier).getCardDetails(
            context: context,
            cardID: widget.card.cardId ?? '',
          );
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        title: StringAssets.debitCards,
        showImage: false,
        showNotification: false,
      ),
      body: Builder(
        builder: (context) {
          if (widget.card.cardStatus != CardStatus.active) {
            return Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 90.ah),
                  SizedBox(
                    height: 260.ah,
                    child: LottieBuilder.asset(LottieAsset.loginAnimation),
                  ),
                  SizedBox(height: 16.ah),
                  Text(
                    StringAssets.activateCardAtATM,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h3.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.rexPurpleLight,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 10.ah),
              RexCardTile(card: widget.card),
              SizedBox(height: 32.ah),
              Visibility(
                visible: widget.card.forcePinChange,
                child: CardOptionsTile(
                  icon: AssetPath.addCard,
                  title: StringAssets.createPin,
                  onTap: () => ref
                      .watch(cardNotifier.notifier)
                      .performNavigateCreatePin(context),
                ),
              ),
              AbsorbPointer(
                absorbing: widget.card.forcePinChange,
                child: Opacity(
                  opacity: widget.card.forcePinChange ? 0.3 : 1.0,
                  child: Column(
                    children: [
                      CardOptionsTile(
                        icon: AssetPath.eyeIcon,
                        title: StringAssets.cardDetails,
                        onTap: () => ref
                            .watch(cardNotifier.notifier)
                            .navigateToCardDetails(
                              context: context,
                              model: ref.watch(cardNotifier).cardDetail ??
                                  CardDetails(),
                            ),
                      ),
                      CardOptionsTile(
                        icon: AssetPath.blockCard,
                        title: StringAssets.blockUnblockCard,
                        onTap: () => ref
                            .watch(cardNotifier.notifier)
                            .navigateToBlockCard(
                              context: context,
                              model: widget.card,
                            ),
                      ),
                      CardOptionsTile(
                        icon: AssetPath.lockCard,
                        title: StringAssets.changePin,
                        onTap: () => ref
                            .watch(cardNotifier.notifier)
                            .performNavigateChangePin(context),
                      ),
                      CardOptionsTile(
                        icon: AssetPath.limitCard,
                        title: StringAssets.cardTransactionLimits,
                        onTap: () => ref
                            .watch(cardNotifier.notifier)
                            .navigateToCardTransactionLimit(context),
                      ),
                      CardOptionsTile(
                        icon: AssetPath.cardIcon,
                        title: StringAssets.cardReplacement,
                        onTap: () => ref
                            .watch(cardNotifier.notifier)
                            .navigateToCardReplacement(context),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
