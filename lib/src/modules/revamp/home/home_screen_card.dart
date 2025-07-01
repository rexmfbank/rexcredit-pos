import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class HomeScreenCard extends StatelessWidget {
  const HomeScreenCard({
    super.key,
    required this.icon,
    required this.label,
    required this.textStyle,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final TextStyle textStyle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              // Color.fromARGB(255, 186, 202, 240),
              Color(0xffF1F5FF),
              Color(0xFFEFF3FF),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: icon,
              // child: Icon(
              //   icon,
              //   size: 30,
              //   color: const Color(0xFF0E234A),
              // ),
            ),
            SizedBox(height: 18.ah),
            Text(
              label,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenAction {
  const HomeScreenAction({required this.label, required this.icon});
  final String label;
  final IconData icon;
}

const homeScreenactions = <HomeScreenAction>[
  HomeScreenAction(label: 'Quick\nPurchase', icon: Icons.credit_card),
  HomeScreenAction(label: 'Quick\nTransfer', icon: Icons.send_rounded),
  HomeScreenAction(label: 'Transaction\nHistory', icon: Icons.receipt_long),
  HomeScreenAction(label: 'EOD Report\nPrinting', icon: Icons.print_rounded),
  HomeScreenAction(
      label: 'Transaction\nDisputes', icon: Icons.chat_bubble_outline),
  HomeScreenAction(label: 'Download\nSettings', icon: Icons.download_rounded),
];

//  HomeScreenAction(
//      label: 'Pending\nTransaction', icon: Icons.warning_amber_rounded),
// HomeScreenAction(label: 'Virtual\nAccount', icon: Icons.account_balance),
// HomeScreenAction(
//      label: 'Notification\nUpdates', icon: Icons.notifications_none),
