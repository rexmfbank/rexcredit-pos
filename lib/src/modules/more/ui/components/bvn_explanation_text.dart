import 'package:flutter/material.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class BvnExplanationText extends StatelessWidget {
  const BvnExplanationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CircleAvatar(
                backgroundColor: Colors.blue.shade200,
                child: const Icon(Icons.priority_high),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Flexible(
                  child: Text(
                    StringAssets.bvnExplanation1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    StringAssets.bvnExplanation2,
                  ),
                ),
                SizedBox(height: 8.0),
                Flexible(
                  child: Text(StringAssets.bvnExplanation3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
