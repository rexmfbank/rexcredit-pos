import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/utils/routes/routes_imports.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/app_keys.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class DashboardHomeAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const DashboardHomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = AppKeysStorage.getConfig().loginFirstname;
    //
    return Padding(
      padding: EdgeInsets.only(top: 45.ah),
      child: Container(
        color: AppColors.rexBackground,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.aw),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.getUsernameGreetings(name),
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.asp,
                    ),
                  ),
                  //const GreetingsText(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.aw),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 4.aw),
                  InkWell(
                    onTap:
                        () => context.push(
                          "${Routes.dashboardMore}/${Routes.profile}",
                        ),
                    child: const Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
