import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/widgets/utility_widget/rex_network_image.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class ProfileScreenAvatar extends ConsumerWidget {
  const ProfileScreenAvatar({
    super.key,
    required this.name,
    required this.accountNumber,
    required this.imageUrl,
  });

  final String name;
  final String accountNumber;
  final String imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      tileColor: AppColors.rexWhite,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: RexNetworkImage(
          image: imageUrl,
          shape: BoxShape.circle,
          useBorderRadius: false,
          height: 32.ah,
          width: 32.aw,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(accountNumber),
      ),
    );
  }
}
