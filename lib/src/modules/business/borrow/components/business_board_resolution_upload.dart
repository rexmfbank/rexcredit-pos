import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';

class BusinessBoardResolutionUpload extends StatelessWidget {
  const BusinessBoardResolutionUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Board resolution',
              style: TextStyle(
                color: AppColors.rexPurpleLight,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.rexWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text('Only .pdf, .jpg and .png files accepted'),
            ),
          ),
          TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: AppColors.rexLightBlue2,
              backgroundColor: AppColors.cardBlue,
              minimumSize: const Size.fromHeight(50),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
            icon: const Icon(Icons.description),
            label: const Text('Upload document'),
          )
        ],
      ),
    );
  }
}
