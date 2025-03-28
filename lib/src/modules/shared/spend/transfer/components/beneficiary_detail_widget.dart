import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BeneficiaryNameWidget extends StatelessWidget {
  final String beneficiaryName;

  const BeneficiaryNameWidget({super.key, required this.beneficiaryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.ar),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light grey background color
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringAssets.beneficiaryName,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
              color: AppColors.rexPurpleDark,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            beneficiaryName,
            style: const TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}

class BeneficiaryInfoWidget extends StatelessWidget {
  final String beneficiarySelected;
  final String beneficiaryName;
  final String beneficiaryBank;
  final String beneficiaryAccountNumber;
  final Function(bool) onCheckboxChanged;

  const BeneficiaryInfoWidget({
    super.key,
    required this.beneficiarySelected,
    required this.beneficiaryName,
    required this.beneficiaryBank,
    required this.beneficiaryAccountNumber,
    required this.onCheckboxChanged,
  });

  bool get _selected => beneficiaryAccountNumber == beneficiarySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.ar),
      decoration: BoxDecoration(
        color: _selected ? AppColors.rexLightBlue : Colors.white,
        borderRadius: BorderRadius.circular(12.ar),
        border: Border.all(
          color: _selected ? AppColors.rexLightBlue2 : Colors.transparent,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  beneficiaryName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.asp,
                    color: Colors.black, // You can change the color
                  ),
                ),
                SizedBox(height: 8.ah),
                Text(
                  beneficiaryBank,
                  style: TextStyle(
                    fontSize: 14.asp,
                    color: AppColors.cardGrey,
                  ),
                ),
                SizedBox(height: 4.ah),
                Text(
                  beneficiaryAccountNumber,
                  style: TextStyle(
                    fontSize: 14.asp,
                    color: AppColors.cardGrey,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: _selected,
            onChanged: (value) => onCheckboxChanged(value ?? false),
          ),
        ],
      ),
    );
  }
}
