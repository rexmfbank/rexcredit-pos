import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/config/theme/app_colors.dart';

class UtilityBillLawma extends ConsumerWidget {
  const UtilityBillLawma({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Upload an image of your LAWMA bill',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.green,
              backgroundColor: AppColors.cardGreen,
              minimumSize: const Size.fromHeight(50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            icon: const Icon(
              Icons.description,
              color: Colors.green,
            ),
            label: const Text('Upload document'),
          ),
        ],
      ),
    );
  }
}
