import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/savings_dialog_button.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/transfer_to_rex_account_card.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class SavedCardsLayout extends HookConsumerWidget {
  const SavedCardsLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = [
      DebitCard(
          "assets/png/visa_icon.png", "**** **** **** 4081", "03/2024", true)
    ];
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
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        items[index].imagePath,
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index].cardNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Expires ${items[index].expirationDate}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Checkbox(
                        value: items[index].isCardSelected,
                        onChanged: (value) {
                          items[index].isCardSelected = value ?? false;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DebitCard {
  final String imagePath;
  final String cardNumber;
  final String expirationDate;
  bool isCardSelected;

  DebitCard(
    this.imagePath,
    this.cardNumber,
    this.expirationDate,
    this.isCardSelected,
  );
}

showAddNewCardBottomSheet({required BuildContext context}) {
  final cardNumberController = TextEditingController();
  bool isSwitched = false;
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Add new Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.rexPurpleDark,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Please enter your card details to add this card to your account',
                style: TextStyle(fontSize: 13, color: AppColors.rexTint500),
              ),
            ),
            RexTextField(
              outerTitle: 'Card Number',
              hintText: '4563 5675 2345 8975',
              controller: cardNumberController,
              obscureText: false,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: RexTextField(
                    outerTitle: 'Expiry Date',
                    hintText: '19/22',
                    controller: cardNumberController,
                    obscureText: false,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RexTextField(
                    outerTitle: 'CVV',
                    hintText: '***',
                    controller: cardNumberController,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Save card details',
                    style: TextStyle(fontSize: 13, color: AppColors.rexTint500),
                  ),
                  Switch(
                    value:
                        isSwitched, // replace _isSwitched with a boolean variable to control the switch state
                    onChanged: (bool value) {
                      isSwitched = value;
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.grey[400],
                    activeTrackColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // add any other customization properties here
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8, left: 16.0, right: 4.0),
                    child: SavingsDialogButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fontSize: 14,
                      textColor: AppColors.rexPurpleDark,
                      title: 'Close',
                      hasIcon: false,
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8, left: 4.0, right: 16.0),
                    child: SavingsDialogButton(
                      onPressed: () {
                        showTopUpModalSheet(context: context);
                      },
                      fontSize: 14,
                      title: 'Add Card',
                      hasIcon: false,
                      textColor: AppColors.rexWhite,
                      backgroundColor: AppColors.rexPurpleDark,
                    ),
                  ),
                ),
              ],
            ),
          ]));
    },
  );
}

void showTopUpModalSheet({required BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.rexWhite,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add money to your account',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.rexPurpleDark,
                          ),
                        ),
                        Text(
                          'Please select preferred payment method',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.rexTint500),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(AssetPath.closeCircularIcon)),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 8.0),
                    TransferToRexAccountCard(),
                    SizedBox(height: 16.0),
                    // PayWithCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
