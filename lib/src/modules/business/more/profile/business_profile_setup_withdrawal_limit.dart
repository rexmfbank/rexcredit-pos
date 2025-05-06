import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/data/rex_api/rex_api.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/providers/set_transaction_limit_provider.dart';
import 'package:rex_app/src/modules/shared/customer_tier/customer_tier_widget.dart';
import 'package:rex_app/src/modules/shared/models/text_field_validator.dart';
import 'package:rex_app/src/modules/shared/providers/app_preference_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/loading_screen.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/show_modal_action.dart';
import 'package:rex_app/src/modules/shared/widgets/modal_bottom_sheets/success_bottom_dialog.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessSetupWithdrawalLimitScreen extends HookConsumerWidget {
  BusinessSetupWithdrawalLimitScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController amountController = useTextEditingController();
    double initialLimit = ref.watch(withdrawalLimitAmountProvider);
    final primaryAccountNo = ref.watch(userNubanProvider);

    //
    ref.listen(setWithdrawalLimitProvider, (_, state) {
      state.when(
        data: (data) {
          LoadingScreen.instance().hide();
          showSuccessModal(
              context,
              'Withdrawal Limit set',
              'You have succesfully set a withdrawal limit',
              'Ok',
              'success_tick', () {
            context.pop();
            context.pop();
          });
        },
        error: (error, stackTrace) {
          LoadingScreen.instance().hide();
          showModalActionError(context: context, errorText: error.toString());
        },
        loading: () => LoadingScreen.instance().show(context: context),
      );
    });
    //

    return Scaffold(
      appBar: const RexAppBar(
        shouldHaveBackButton: true,
        step: '',
        title: StringAssets.setWithdrawalLimitTitle,
        subtitle: 'Adjust the slider below to set your preferred limit',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          //physics: const BouncingScrollPhysics(),
          children: [
            TransactionLimitCardWidget(
              amountController: amountController,
              initialLimit: initialLimit,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: RexFlatButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    SetWithdrawalLimitRequest requestForm =
                        SetWithdrawalLimitRequest(
                      accountNumber: primaryAccountNo,
                      amount: int.tryParse(amountController.text) ?? 20000,
                    );
                    ref
                        .read(setWithdrawalLimitProvider.notifier)
                        .setWithdrawalLimit(request: requestForm);
                  }
                },
                buttonTitle: StringAssets.saveText,
                backgroundColor: null,
              ),
            ),
            const Expanded(child: CustomerTierWidget()),
          ],
        ),
      ),
    );
  }
}

class TransactionLimitCardWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TransactionLimitCardWidgetState();

  TransactionLimitCardWidget({
    super.key,
    required this.amountController,
    required this.initialLimit,
  });

  final TextEditingController amountController;
  double initialLimit;
}

class TransactionLimitCardWidgetState
    extends State<TransactionLimitCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringAssets.amount,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
              color: AppColors.rexPurpleDark,
            ),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: widget.amountController,
            onChanged: (value) {},
            autovalidateMode: AutovalidateMode.disabled,
            keyboardType: TextInputType.number,
            validator: (value) => TextfieldValidator.amount(value),
            decoration: InputDecoration(
              prefixIcon: null,
              suffixIcon: null,
              fillColor: AppColors.rexBackground,
              filled: true,
              hintText: 'N450,000',
              focusedBorder: AppConstants.rexInputBorder,
              enabledBorder: AppConstants.rexInputBorder,
              border: AppConstants.rexInputBorder,
              counterText: '',
            ),
          ),
          CustomSlider(
            minValue: 0,
            maxValue: 1000000,
            value: widget.initialLimit,
            divisions: 200,
            sliderColor: AppColors.rexBrown,
            onChanged: (value) {
              setState(() => widget.initialLimit = value);
            },
            amountController: widget.amountController,
          )
        ],
      ),
    );
  }
}

class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double value;
  final Color sliderColor;
  final int? divisions;
  final ValueChanged<double> onChanged;
  final TextEditingController? amountController;

  const CustomSlider({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.sliderColor,
    required this.onChanged,
    this.amountController,
    this.divisions,
  });

  @override
  CustomSliderState createState() => CustomSliderState();
}

class CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.minValue.toStringAsFixed(0)}K",
                style: const TextStyle(
                    color: AppColors.rexPurpleDark,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${widget.maxValue.toStringAsFixed(0)}K",
                style: const TextStyle(
                    color: AppColors.rexPurpleDark,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Slider(
          value: widget.value,
          min: widget.minValue,
          max: widget.maxValue,
          divisions: widget.divisions ?? 0,
          onChanged: (newValue) {
            widget.onChanged(newValue);
            if (widget.amountController != null) {
              widget.amountController!.text = newValue.toStringAsFixed(0);
            }
          },
          activeColor: widget.sliderColor,
        ),
      ],
    );
  }
}
