import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/models/welcome_model.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/provider/welcome_page_view_notifier.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/ui/components/welcome_slide.dart';

class WelcomeScreen extends HookConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: ref.watch(welcomeNotifier).walkthroughController,
              itemCount: welcomePages.length,
              onPageChanged: (int index) {
                ref.read(welcomePageViewProvider.notifier).onPageChanged(index);
              },
              itemBuilder: (context, index) {
                return WelcomeSlide(
                  welcomeModel: welcomePages[index],
                  pageController:ref.watch(welcomeNotifier).walkthroughController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
