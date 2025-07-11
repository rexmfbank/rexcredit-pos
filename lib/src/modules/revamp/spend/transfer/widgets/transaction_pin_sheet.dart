import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class TransactionPinSheet extends StatefulWidget {
  final Function(String pin)? onPinComplete;
  final int pinLength;
  final String? title;

  const TransactionPinSheet({
    super.key,
    this.onPinComplete,
    this.title,
    this.pinLength = 4,
  });

  @override
  State<TransactionPinSheet> createState() => _TransactionPinSheetState();
}

class _TransactionPinSheetState extends State<TransactionPinSheet> {
  String _pin = '';
  List<String> _displayValues = [];
  final List<Timer> _timers = [];

  @override
  void initState() {
    super.initState();
    _displayValues = List.filled(widget.pinLength, '');
  }

  @override
  void dispose() {
    for (var timer in _timers) {
      timer.cancel();
    }
    super.dispose();
  }

  void _addDigit(String digit) {
    if (_pin.length < widget.pinLength) {
      setState(() {
        _pin += digit;
        _displayValues[_pin.length - 1] = digit;

        Timer timer = Timer(const Duration(milliseconds: 150), () {
          if (mounted) {
            setState(() {
              _displayValues[_pin.length - 1] = '*';
            });
          }
        });
        _timers.add(timer);
      });

      // Check if PIN is complete
      if (_pin.length == widget.pinLength && widget.onPinComplete != null) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            widget.onPinComplete!(_pin);
          }
        });
      }
    }
  }

  void _removeLastDigit() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _displayValues[_pin.length] = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? 'Confirm Transfer',
            style: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17.asp,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Please enter your transaction pin to proceed.',
            style: AppTextStyles.body2Regular.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 13.asp,
                color: AppColors.rexTint400),
          ),
          const SizedBox(height: 36),
          //----->>>>>> PIN display boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.pinLength,
              (index) => Container(
                width: 80,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    _displayValues[index],
                    style: AppTextStyles.body2Regular.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 29.asp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          //---->>>>> Number pad
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNumberButton('1'),
                    _buildNumberButton('2'),
                    _buildNumberButton('3'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNumberButton('4'),
                    _buildNumberButton('5'),
                    _buildNumberButton('6'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNumberButton('7'),
                    _buildNumberButton('8'),
                    _buildNumberButton('9'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 50, height: 50),
                    _buildNumberButton('0'),
                    _buildDeleteButton(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return InkWell(
      onTap: () => _addDigit(number),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          number,
          style: AppTextStyles.body2Regular.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 19.asp,
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _removeLastDigit,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: SizedBox(
          width: 30,
          height: 30,
          child: SvgPicture.asset(AssetPath.deleteButton),
        ),
      ),
    );
  }
}
