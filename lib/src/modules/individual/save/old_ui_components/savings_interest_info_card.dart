import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/currency.dart';

class SavingsInterestInfoCard extends StatelessWidget {
  final String interestAccrued;
  const SavingsInterestInfoCard({Key? key, required this.interestAccrued})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        color: Color.fromARGB(255, 235, 239, 248),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/png/bulb_icon.png', width: 20.0, height: 20.0),
          const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Your earned interest is ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      addNairaCurrencySymbol(
                          interestAccrued == "null" ? "0" : interestAccrued),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Based on your monthly deposits, you are likely to achieve your goal in time. Keep on going!',
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
