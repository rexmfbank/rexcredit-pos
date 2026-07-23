import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_actions.dart';
import 'package:rex_app/src/modules/login/login_home/login_home_card.dart';
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hello John'),
              Row(
                children: [
                  Icon(Icons.notifications),
                  Icon(Icons.notifications),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xff1D58BD),
              borderRadius: BorderRadius.circular(14),
            ),
            child: LoginHomeCard(),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: LoginHomeActions(),
          ),
        ],
      ),
    );
  }
}
