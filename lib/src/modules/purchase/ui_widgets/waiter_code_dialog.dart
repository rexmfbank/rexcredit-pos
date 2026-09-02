import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/rex_elevated_button.dart';

Future<String?> showWaiterCodeDialog({required BuildContext context}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => const _WaiterCodeDialog(),
  );
}

class _WaiterCodeDialog extends StatefulWidget {
  const _WaiterCodeDialog();

  @override
  State<_WaiterCodeDialog> createState() => _WaiterCodeDialogState();
}

class _WaiterCodeDialogState extends State<_WaiterCodeDialog> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String _code = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: 52.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.rexPurpleDark3,
      ),
      decoration: BoxDecoration(
        color: AppColors.rexWhite,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Waiter Code',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.rexPurpleDark3,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: AppColors.rexLightBlue4,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Pinput(
                length: 4,
                controller: _controller,
                focusNode: _focusNode,
                obscureText: true,
                obscuringCharacter: '•',
                defaultPinTheme: pinTheme,
                focusedPinTheme: pinTheme.copyWith(
                  decoration: pinTheme.decoration!.copyWith(
                    border: Border.all(color: AppColors.rexPurpleLight),
                  ),
                ),
                onChanged: (value) => setState(() => _code = value),
                onCompleted: (value) => setState(() => _code = value),
              ),
            ),
            SizedBox(height: 16.h),
            RexElevatedButton(
              buttonTitle: 'Confirm',
              verticalPadding: 8,
              onPressed:
                  _code.length == 4
                      ? () => Navigator.of(context).pop(_code)
                      : null,
              backgroundColor:
                  _code.length == 4
                      ? AppColors.rexPurpleLight
                      : AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
