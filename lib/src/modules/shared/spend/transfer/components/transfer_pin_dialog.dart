import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_components/pin_input_layout.dart';

void showTransferPinModalSheet({
  required BuildContext context,
  required Function(String) onPinEntered,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.rexWhite,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    ),
    builder: (context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Confirm Transfer",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.rexPurpleDark,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                      child: Text(
                        "Please enter your transaction pin to poceed",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(110, 113, 145, 1),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: AppColors.rexBackground,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: PinInputLayout(
                        onPinEntered: onPinEntered,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
