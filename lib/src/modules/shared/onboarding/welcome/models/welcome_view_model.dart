import 'package:flutter/material.dart';

class WelcomeViewModel {
  final PageController walkthroughController;
  final List<Animation<double>> animationCount;
  final List<AnimationController> controller;
  final int startCount;
  final int currentIndex;

  const WelcomeViewModel({
    required this.walkthroughController,
    this.animationCount = const [],
    this.controller = const [],
    this.startCount = 0,
    this.currentIndex = 0,
  });

  WelcomeViewModel copyWidth({
    PageController? walkthroughController,
    List<Animation<double>>? animationCount,
    List<AnimationController>? controller,
    int? startCount,
    int? currentIndex,
  }) {
    return WelcomeViewModel(
      walkthroughController:
          walkthroughController ?? this.walkthroughController,
      animationCount: animationCount ?? this.animationCount,
      controller: controller ?? this.controller,
      startCount: startCount ?? this.startCount,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
