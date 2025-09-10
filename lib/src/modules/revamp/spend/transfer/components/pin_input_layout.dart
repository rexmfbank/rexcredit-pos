import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class PinInputLayout extends StatefulWidget {
  final void Function(String) onPinEntered;

  const PinInputLayout({super.key, required this.onPinEntered});

  @override
  State<StatefulWidget> createState() => _PinInputLayoutState();
}

class _PinInputLayoutState extends State<PinInputLayout> {
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  static const List<String> keypadValues = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    'delete',
  ];

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleKeyPress(String value) {
    if (value == 'delete') {
      for (var i = _pinControllers.length - 1; i >= 0; i--) {
        if (_pinControllers[i].text.isNotEmpty) {
          setState(() {
            _pinControllers[i].clear();
          });
          break;
        }
      }
    } else {
      for (var i = 0; i < _pinControllers.length; i++) {
        if (_pinControllers[i].text.isEmpty) {
          setState(() {
            _pinControllers[i].text = value;
          });
          if (i == _pinControllers.length - 1) {
            // If last pin box is filled, trigger pin entered callback
            widget.onPinEntered(
              _pinControllers.map((controller) => controller.text).join(),
            );
          }
          break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        color: AppColors.rexBackground,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pin Input TextField
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    _pinControllers.map((controller) {
                      return Container(
                        width: 50.w,
                        height: 48.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.rexBackground,
                          border: Border.all(color: AppColors.rexBackground),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          obscureText: true,
                          obscuringCharacter: '*',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),

            // Pin Input Keypad
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              crossAxisSpacing: 16.0,
              children:
                  keypadValues.map((value) {
                    return InkWell(
                      onTap: () => _handleKeyPress(value),
                      child: Container(
                        alignment: Alignment.center,
                        child:
                            value == 'delete'
                                ? const Icon(Icons.backspace_outlined)
                                : Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
