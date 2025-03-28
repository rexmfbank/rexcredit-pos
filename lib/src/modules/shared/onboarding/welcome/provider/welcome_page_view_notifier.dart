import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/models/welcome_view_model.dart';

final welcomePageViewProvider = NotifierProvider<WelcomePageViewNotifier, int>(
  () => WelcomePageViewNotifier(),
);

///Welcome page notifier provider
final welcomeNotifier = NotifierProvider<WelcomePageNotifier, WelcomeViewModel>(
    () => WelcomePageNotifier());

class WelcomePageViewNotifier extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void onPageChanged(int index) {
    state = index;
  }
}

class WelcomePageNotifier extends Notifier<WelcomeViewModel> {
  @override
  WelcomeViewModel build() {
    return WelcomeViewModel(
      walkthroughController: PageController(),
    );
  }

  void initialize({required int storyCount, required TickerProvider vsync}) {
    state = state.copyWidth(
        controller: List.generate(
          storyCount,
              (index) => AnimationController(
            vsync: vsync,
            duration: const Duration(seconds: 2),
          ),
        ),
    );
    state = state.copyWidth(
        animationCount: List.generate(
          storyCount,
              (index) => Tween(
            begin: 0.0,
            end: 1.0,
          ).animate(state.controller[index]),
        ),
    );

    state.controller[state.startCount].forward(from: 0);
  }

  void initOnBoardingAnimation(int storyCount) {
    while (state.startCount < storyCount) {
      state.controller[state.startCount].forward(from: 0).whenComplete(() {
        state.startCount < (storyCount - 1)
            ? state.controller[state.startCount + 1].forward(from: 0)
            : null;
        state = state.copyWidth(startCount: state.startCount + 1);
        state = state.copyWidth(currentIndex: state.startCount);
      });
    }
  }

  void nextPageTap() {}
}
