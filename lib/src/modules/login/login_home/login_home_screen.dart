import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_actions.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_appbar.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_card.dart';
import 'package:rex_app/src/modules/login/provider/dashboard_provider.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class LoginHomeScreen extends ConsumerStatefulWidget {
  const LoginHomeScreen({super.key});

  @override
  ConsumerState<LoginHomeScreen> createState() => _LoginHomeScreenState();
}

class _LoginHomeScreenState extends ConsumerState<LoginHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider.notifier).fetchBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      appBar: LoginHomeAppbar(),
      padding: EdgeInsets.all(0),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: AppColors.rexPurpleLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: LoginHomeCard(),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 8.0, top: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: LoginHomeActions(),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
