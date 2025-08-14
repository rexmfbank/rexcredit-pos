import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ProfileSlide extends ConsumerWidget {
  const ProfileSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RexListTile(
          leadingWidget: Image.asset(AssetPath.moreProfileIcon),
          title: StringAssets.personalInfoTitle,
          subtitle: StringAssets.personalInfoProfileSubtitle,
          hasTrailingIcon: true,
          onTap: () {
            // context.push(
            //   "${RouteName.dashboardMore}/${RouteName.personalInfo}",
            // );
            context.push(
              "${Routes.dashboardMore}/${Routes.personalProfile}",
            );
          },
        ),
        // RexListTile(
        //   leadingWidget: Image.asset(AssetPath.profileKinIcon),
        //   title: StringAssets.kinTitle,
        //   subtitle: StringAssets.profileKinTitle,
        //   hasTrailingIcon: true,
        //   onTap: () {
        //     context.push(
        //       "${Routes.dashboardMore}/${Routes.nextOfKin}",
        //     );
        //   },
        // ),
      ],
    );
  }
}
