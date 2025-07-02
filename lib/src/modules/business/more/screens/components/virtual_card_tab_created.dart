import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/config/routes/route_name.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_list_tile.dart';
import 'package:rex_app/src/utils/constants/asset_path.dart';

class VirtualCardTabCreated extends StatelessWidget {
  const VirtualCardTabCreated({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        children: [
          Image.asset(AssetPath.imageMastercard),
          RexListTile(
            title: 'Set spend limit',
            subtitle: 'Set a daily transaction limit',
            hasTrailingIcon: true,
            leadingWidget: Image.asset(AssetPath.imageCardLogo),
            onTap: () {
              context.push(
                "${Routes.dashboardMoreBusiness}/${Routes.cardsSpendLimit}",
              );
            },
          ),
          RexListTile(
            title: 'Block card',
            subtitle: 'Temporarily disable card',
            hasTrailingIcon: true,
            leadingWidget: Image.asset(AssetPath.imageCardLogo),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
