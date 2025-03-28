import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_elevated_button.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_text_field.dart';

class BusinessAddCardScreen extends HookConsumerWidget {
  const BusinessAddCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final numberController = useTextEditingController();
    final cvcController = useTextEditingController();
    final dateController = useTextEditingController();
    //
    return Scaffold(
      appBar: const RexAppBar(
        step: '',
        shouldHaveBackButton: true,
        title: 'Add Card',
        subtitle: 'Add new card to make spendings',
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          RexTextField(
            outerTitle: 'Card holder name',
            hintText: '',
            controller: nameController,
            obscureText: false,
          ),
          RexTextField(
            outerTitle: 'Card number',
            hintText: '',
            controller: numberController,
            obscureText: false,
          ),
          RexTextField(
            outerTitle: 'CVC',
            hintText: '',
            controller: cvcController,
            obscureText: false,
          ),
          RexTextField(
            outerTitle: 'Expiry date',
            hintText: '',
            controller: dateController,
            obscureText: false,
          ),
          RexElevatedButton(
            onPressed: () {
              showModalAction(
                context: context,
                dialogTitle: 'Card Added',
                dialogSubtitle: 'You have successfully add a new card',
                onPressed: () {
                  context.pop();
                  context.go(
                      "${RouteName.dashboardBusiness}/${RouteName.businessLoanRepayment}");
                },
              );
            },
            buttonTitle: 'Add Card',
            backgroundColor: null,
          ),
        ],
      ),
    );
  }
}
