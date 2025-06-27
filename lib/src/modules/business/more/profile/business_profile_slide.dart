import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BusinessProfileSlide extends ConsumerWidget {
  const BusinessProfileSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        RexListTile(
          leadingWidget: Image.asset(AssetPath.moreProfileIcon),
          title: StringAssets.businessInfoTitle,
          subtitle: StringAssets.businessInfoProfileSubtitle,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardMoreBusiness}/${Routes.businessInfo}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.profileKinIcon),
          title: StringAssets.representativeText,
          subtitle: StringAssets.representativeSubtext,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardMoreBusiness}/${Routes.enterBusinessRepresentative}",
            );
          },
        ),
        RexListTile(
          leadingWidget: Image.asset(AssetPath.profileKinIcon),
          title: StringAssets.businessDirectorsText,
          subtitle: StringAssets.businessDirectorsSubText,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardMoreBusiness}/${Routes.addBusinessDirector}",
            );
          },
        ),
        RexListTile(
          leadingWidget: SvgPicture.asset(
            AssetPath.docUploadIcon,
            height: 30.ah,
            width: 25.aw,
            color: AppColors.rexLightBlue2,
          ),
          title: StringAssets.businessDocumentText,
          subtitle: StringAssets.businessDocumentSubText,
          hasTrailingIcon: true,
          onTap: () {
            context.push(
              "${Routes.dashboardMoreBusiness}/${Routes.businessKycDocuments}",
            );
          },
        ),
      ],
    );
  }
}
