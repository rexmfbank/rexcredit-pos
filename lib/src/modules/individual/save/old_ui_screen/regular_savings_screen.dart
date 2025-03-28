import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_screen/empty_regular_savings_screen.dart';
import 'package:rex_app/src/modules/individual/save/old_ui_screen/non_empty_regular_savings_screen.dart';

class RegularSavingsScreen extends StatelessWidget {
  const RegularSavingsScreen({super.key});
  final isSavingsEmpty = false;

  @override
  Widget build(BuildContext context) {
    if (isSavingsEmpty) {
      return const EmptyRegularSavingsScreen();
    } else {
      return const NonEmptyRegularSavingsScreen();
    }
  }
}
