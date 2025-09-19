import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/app_primary_button.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui_widgets/int_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/extensions/extension_on_string.dart';

class CustomNumberPadWidget extends StatefulWidget {
  final String? title;
  final Function(String)? onChange;
  //final bool loading;
  final String? hint;
  final bool clear;
  final Widget? actionButton;
  final int maxDigits;
  //final PreferredSizeWidget? appBar;

  const CustomNumberPadWidget({
    super.key,
    this.title,
    this.clear = false,
    this.hint,
    this.onChange,
    this.actionButton,
    //this.loading = false,
    this.maxDigits = 7, // Default to 7-digit max
    //this.appBar,
  });

  @override
  State<CustomNumberPadWidget> createState() => _CustomNumberPadWidgetState();
}

class _CustomNumberPadWidgetState extends State<CustomNumberPadWidget> {
  String _enteredNumber = "";

  void _onNumberPress(String number) {
    if (_enteredNumber.length < widget.maxDigits) {
      setState(() {
        _enteredNumber += number;
        widget.onChange?.call(_enteredNumber);
      });
    }
  }

  void _onDeletePress() {
    if (_enteredNumber.isNotEmpty) {
      setState(() {
        _enteredNumber = _enteredNumber.substring(0, _enteredNumber.length - 1);
        widget.onChange?.call(_enteredNumber);
      });
    }
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberPress(number),
      child: Container(
        width: 104.0,
        height: 72.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(208),
          color: AppColors.containerBgColor,
        ),
        child: Text(
          number,
          style: TextStyle(
            fontSize: 36,
            color: AppColors.textBlack,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: _onDeletePress,
      child: Container(
        width: 104.0,
        height: 72.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(208),
          color: AppColors.containerBgColor,
        ),
        child: const Icon(Icons.backspace),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            16.spaceHeight(),
            Text(
              _enteredNumber.formatCurrencyString(),
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.spaceHeight(),
            GridView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 72,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(0),
              children: [
                ...List.generate(9, (index) {
                  return _buildNumberButton('${index + 1}');
                }),
                Container(), // Empty placeholder
                _buildNumberButton('0'),
                _buildDeleteButton(),
              ],
            ),
            20.spaceHeight(),
            widget.actionButton ?? const AppPrimaryButton(text: "Confirm"),
          ],
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: widget.loading,
      appBar: widget.appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              16.spaceHeight(),
              Text(
                _enteredNumber.formatCurrencyString(),
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              20.spaceHeight(),
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 72,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(0),
                children: [
                  ...List.generate(9, (index) {
                    return _buildNumberButton('${index + 1}');
                  }),
                  Container(), // Empty placeholder
                  _buildNumberButton('0'),
                  _buildDeleteButton(),
                ],
              ),
              20.spaceHeight(),
              widget.actionButton ?? const AppPrimaryButton(text: "Confirm"),
            ],
          ),
        ),
      ),
    );
  }*/
}
