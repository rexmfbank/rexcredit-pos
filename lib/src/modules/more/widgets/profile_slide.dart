import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/routes/route_name.dart';

import 'package:rex_app/src/modules/utils/widgets/rex_list_tile.dart';
import 'package:rex_app/src/modules/utils/general/asset_path.dart';
import 'package:rex_app/src/modules/utils/general/app_strings.dart';

class ProfileSlide extends ConsumerWidget {
  const ProfileSlide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RexListTile(
          leadingWidget: Image.asset(AssetPath.moreProfileIcon),
          title: Strings.personalInfoTitle,
          subtitle: Strings.personalInfoProfileSubtitle,
          hasTrailingIcon: true,
          onTap: () {
            // context.push(
            //   "${RouteName.dashboardMore}/${RouteName.personalInfo}",
            // );
            context.push("${Routes.dashboardMore}/${Routes.personalProfile}");
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
