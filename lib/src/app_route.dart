import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/utils/service/secure_storage.dart';

class AppRoute {
  static const firstLaunch = 'FL';
  static const loggedIn = 'LI';
  static const loggedOut = 'LO';

  void routeNavigation(BuildContext context) async {
    final appNav = await SecureStorage().getLaunchState();
    if(context.mounted){
      switch (appNav) {
        case firstLaunch:
        context.go(RouteName.selectCountry);
          break;

        case loggedIn:
        case loggedOut:
          context.go(RouteName.login);
          break;

        default:
          context.go(RouteName.selectCountry);
          break;
      }
    }
  }
}
