import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/chat/chat_screen_widget.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/modules/shared/widgets/rex_appbar.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffold(
      appBar: RexAppBar(
        shouldHaveBackButton: true,
        title: StringAssets.chatScreenT1,
        subtitle: StringAssets.chatScreenT2,
      ),
      body: ChatScreenWidget(),
    );
  }
}
