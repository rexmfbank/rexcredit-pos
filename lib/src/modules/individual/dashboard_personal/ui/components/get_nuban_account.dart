import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GetNubanAccount extends ConsumerWidget {
  const GetNubanAccount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.lightBlue2,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        margin: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 8.0,
          bottom: 16.0,
        ),
        padding: const EdgeInsets.all(16.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(radius: 24),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'Complete your Profile',
                      style: TextStyle(
                        color: AppColors.rexBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'Setup your individual account to get started',
                      style: TextStyle(
                        color: AppColors.rexBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.0),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.rexPurpleLight,
            ),
          ],
        ),
      ),
    );
  }
}
