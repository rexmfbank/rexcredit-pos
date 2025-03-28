import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_flat_button.dart';

class PreviewProductWidget extends StatelessWidget {
  const PreviewProductWidget({super.key});

  @override
  Widget build(Object context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              child: Image.asset(
                'assets/png/product_image.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Product Name',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'N450,000',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                )),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'An eau de toilette fragrance or perfume bears a robust aroma that resides for a longer duration ',
                  style: TextStyle(color: AppColors.grey),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: RexFlatButton(
              onPressed: () {},
              buttonTitle: 'Pay N450,000',
              borderColor: AppColors.rexLightBlue2,
              backgroundColor: AppColors.rexLightBlue2,
            ),
          )
        ],
      ),
    );
  }
}
