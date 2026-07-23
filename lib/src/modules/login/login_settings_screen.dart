import 'package:flutter/widgets.dart';

class LoginSettingsScreen extends StatefulWidget {
  const LoginSettingsScreen({super.key});

  @override
  State<LoginSettingsScreen> createState() => _LoginSettingsScreenState();
}

class _LoginSettingsScreenState extends State<LoginSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Login Settings Screen'));
  }
}
