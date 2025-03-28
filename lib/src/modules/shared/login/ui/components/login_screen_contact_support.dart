import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/routes/route_name.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class LoginScreenContactSupport extends ConsumerWidget {
  const LoginScreenContactSupport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Divider(),
        TextButton.icon(
          onPressed: () => context.push(RouteName.chatScreen),
          label: const Text(
            "${StringAssets.richText5} ${StringAssets.richText6}",
          ),
          icon: const Icon(Icons.message),
        ),
      ],
    );
  }
}
