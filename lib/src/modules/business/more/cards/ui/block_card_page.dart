import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/cards/components/rex_card_tile.dart';
import 'package:rex_app/src/modules/business/more/cards/notifier/card_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/modules/shared/widgets/dropdown/custom_dropdown_button.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_textfield_required_rich_text.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BlockCardPage extends ConsumerStatefulWidget {
  final CardListDetails model;
  const BlockCardPage({super.key, required this.model});

  @override
  ConsumerState<BlockCardPage> createState() => _BlockCardPageState();
}

class _BlockCardPageState extends ConsumerState<BlockCardPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      !widget.model.isBlocked
          ? ref.read(cardNotifier.notifier).getBlockReasons(context)
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: ref.watch(cardNotifier).isLoading,
      backgroundColor: AppColors.rexBackgroundGrey,
      appBar: CustomAppBar(
        title: StringAssets.blockDebitCard,
        showImage: false,
        showNotification: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.ah),
          RexCardTile(
            card: widget.model,
            showBlockedStatus: true,
          ),
          SizedBox(height: 30.ah),
          Visibility(
            visible: !widget.model.isBlocked,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RexTextFieldRichText(
                  title1: StringAssets.selectReason,
                  color1: AppColors.rexPurpleDark2,
                ),
                SizedBox(height: 7.ah),
                CustomDropDownButton(
                  height: 56.ah,
                  items: ref
                      .watch(cardNotifier)
                      .cardBlockReasons
                      .map((e) => e.description ?? '')
                      .toList(),
                  backGroundColor: AppColors.rexWhite,
                  dropdownValue: ValueNotifier(
                      ref.watch(cardNotifier).selectedBlockReason),
                  withHint: false,
                  onChanged: (String? value) => ref
                      .watch(cardNotifier.notifier)
                      .updateBlockedReason(value),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RexFlatButton(
            onPressed: () => ref.watch(cardNotifier.notifier).performCardAction(
                  context: context,
                  value: widget.model.isBlocked,
                ),
            buttonTitle: widget.model.isBlocked
                ? StringAssets.unblock
                : StringAssets.block,
            backgroundColor: AppColors.rexPurpleLight,
          ),
          SizedBox(height: 15.ah),
        ],
      ),
    );
  }
}
