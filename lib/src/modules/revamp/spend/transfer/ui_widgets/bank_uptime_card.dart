import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/modules/revamp/utils/routes/route_name.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';

class BankUptimeCard extends StatelessWidget {
  const BankUptimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListTile(
        onTap: () {
          context.push("${Routes.dashboardIndividual}/${Routes.bankUptime}");
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(12)),
        ),
        tileColor: AppColors.rexLightBlue5,
        leading: Image.asset("assets/png/uptime_icon.png"),
        title: Text('Check Bank Transfer Uptime'),
        trailing: Icon(Icons.navigate_next_sharp),
      ),
    );
  }
}
