import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexBackDoubleButton extends StatelessWidget {
  const RexBackDoubleButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
    this.onBackPressed,
    this.backgroundColor,
    this.backButtonColor,
    this.foregroundColor,
    this.width,
  });

  final void Function()? onPressed;
  final VoidCallback? onBackPressed;
  final String buttonTitle;
  final Color? backgroundColor;
  final Color? backButtonColor;
  final Color? foregroundColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    double screenWidth =AppConstants.deviceWidth;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.ah),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: InkWell(
              onTap: (){
                if(onBackPressed!=null){
                  onBackPressed!.call();
                  return;
                }
                context.pop();
              },
              child: Container(
                padding: EdgeInsets.all(12.ar),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.ar),
                  border: Border.all(
                    width: 1.5.aw,
                    color: backButtonColor ?? AppColors.rexPurpleLight,
                  ),
                ),
                child: Icon(
                  Icons.arrow_back_sharp,
                  size: 30.ar,
                  color:backButtonColor ?? AppColors.rexPurpleLight,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.aw),
          Flexible(
            flex: 5,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? AppColors.rexPurpleLight,
                foregroundColor: foregroundColor,
                minimumSize: Size(
                  0.9 * screenWidth,
                  0.15 * screenWidth,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14.ar),
                  ),
                ),
              ),
              child: Text(
                buttonTitle,
                style: AppTextStyles.body1Regular.copyWith(
                  color: AppColors.rexWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
