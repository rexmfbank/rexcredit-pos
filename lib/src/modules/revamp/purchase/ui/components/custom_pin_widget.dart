import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/app_primary_button.dart';
import 'package:rex_app/src/modules/revamp/purchase/ui/components/int_ext.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/custom_app_bar.dart';

class CustomPinWidget extends StatefulWidget {
  final bool create;
  final String? title;
  final Function(String)? onChange;
  final bool loading;
  final String? hint;
  final bool clear;
  final Widget? actionButton;
  final PreferredSizeWidget? appBar;

  const CustomPinWidget({
    super.key,
    this.create = true,
    this.title,
    this.clear = false,
    this.hint,
    this.onChange,
    this.actionButton,
    this.loading = false,
    this.appBar,
  });

  @override
  State<CustomPinWidget> createState() => _CustomPinWidgetState();
}

class _CustomPinWidgetState extends State<CustomPinWidget> {
  final List<String> _pin = ['', '', '', ''];

  int _currentIndex = 0;

  void _onNumberPress(String number) {
    if (_currentIndex < 4) {
      setState(() {
        _pin[_currentIndex] = number;
        widget.onChange?.call(_pin.join());
        _currentIndex++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _onDeletePress() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = '';
        widget.onChange?.call(_pin.join());
      });
    }
  }

  // void _onNextPress() {
  //   String enteredPin = _pin.join('');
  // }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => _onNumberPress(number),
      child: Container(
        width: 104.0,
        height: 72.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(208),
          color: Color(0x15A4A9AE),
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
          color: Color(0x15A4A9AE),
        ),
        child: const Icon(Icons.cancel_presentation),
      ),
    );
  }

  Widget _buildPinButton() {
    return const AppPrimaryButton(text: "Set pin");
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: widget.loading,
      appBar: widget.appBar ?? CustomAppBar(title: widget.title ?? ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              60.spaceHeight(),
              Text(
                widget.hint ?? 'Enter your 4-digit PIN',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              40.spaceHeight(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 17.0,
                    height: 40.0,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 4.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      _pin[index],
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
              30.spaceHeight(),
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 104.0,
                      height: 72.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          208,
                        ),
                        color: Color(0x15A4A9AE),
                      ),
                      child: 0.verticalSpace,
                    ),
                  ),
                  _buildNumberButton('0'),
                  _buildDeleteButton(),
                ],
              ),
              40.spaceHeight(),
              widget.actionButton ?? _buildPinButton(),
            ],
          ),
        ),
      ),
    );
  }
}
