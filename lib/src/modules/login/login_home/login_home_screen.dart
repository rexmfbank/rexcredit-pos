import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_actions.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_card.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/widgets/app_scaffold.dart';

class LoginHomeScreen extends StatefulWidget {
  const LoginHomeScreen({super.key});

  @override
  State<LoginHomeScreen> createState() => _LoginHomeScreenState();
}

class _LoginHomeScreenState extends State<LoginHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.rexBackground,
      padding: EdgeInsets.all(0),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hello John',
                  style: TextStyle(
                    color: AppColors.rexPurpleLight,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.asp,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.notifications),
                    SizedBox(width: 4),
                    Icon(Icons.notifications),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Color(0xff1D58BD),
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
