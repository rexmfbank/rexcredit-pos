import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/business/more/profile/business_information/providers/business_info_screen_provider.dart';
import 'package:rex_app/src/modules/shared/onboarding/onboard_business/business_bio/provider/business_bio_provider.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_rich_text.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

List<String> get _industryList => [
      'Manufacturing',
      'Retail',
      'Hospitality',
      "Education",
      "Non-Governmental Organization",
      "Oil & Gas",
      "Information and Communications Technology",
      "Healthcare",
      "Financial Services",
      "Construction/Real Estate",
      "Agriculture",
      "Sports Betting",
      "Printing/publishing",
      "Advertising",
    ];

class BusinessIndustryDropdown extends ConsumerStatefulWidget {
  final String? initialValue;
  const BusinessIndustryDropdown({super.key, this.initialValue});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BusinessIndustryDropdownState();
}

class _BusinessIndustryDropdownState
    extends ConsumerState<BusinessIndustryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.aw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          RexRichText(
            title1: StringAssets.industry,
            textStyle1: AppTextStyles.body2Regular.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.rexPurpleDark,
            ),
            title2: ' *',
            textDecoration2: TextDecoration.none,
            color2: AppColors.red,
            alignment: Alignment.centerLeft,
          ),
          SizedBox(height: 8.ah),
          Container(
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: DropdownButtonFormField(
              value: widget.initialValue,
              items: _industryList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
              onChanged: (value) {
                ref
                    .watch(businessInfoProvider.notifier)
                    .setSelectedBusinessSector(value);
                ref
                    .read(businessBioProvider.notifier)
                    .onBusinessIndustryDropdownChange(value);
              },
              decoration: InputDecoration(
                focusColor: Colors.black,
                border: AppConstants.rexInputBorder,
                enabledBorder: AppConstants.rexInputBorder,
                focusedBorder: AppConstants.rexInputBorder,
              ),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }
}
