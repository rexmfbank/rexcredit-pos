import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/models/welcome_model.dart';
import 'package:rex_app/src/modules/shared/onboarding/welcome/provider/welcome_page_view_notifier.dart';
import 'package:rex_app/src/modules/shared/widgets/page_widgets/app_scaffold.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/constants/ui_paddings.dart';

class OnBoardingWidget extends ConsumerStatefulWidget {
  final int storyCount;
  final List<WelcomeModel> storyModel;
  const OnBoardingWidget({
    super.key,
    required this.storyCount,
    required this.storyModel,
  });

  @override
  ConsumerState<OnBoardingWidget> createState() => _OnBoardingWidgetState();
}

class _OnBoardingWidgetState extends ConsumerState<OnBoardingWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    ref.read(welcomeNotifier.notifier).initialize(
          storyCount: widget.storyCount,
          vsync: this,
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      padding: UiPaddings.padding16LR,
      backgroundColor: AppColors.rexBlack,
      body: Column(
        children: [
          SizedBox(height: 22.ah),
          progressBar(count: widget.storyCount),
        ],
      ),
    );
  }

  Widget progressBar({required int count}) => Row(
        children: List.generate(
          count,
          (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5.aw),
            child: SizedBox(
              width: 80.aw,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppConstants.size.storyBarRadius),
                ),
                child: LinearProgressIndicator(
                  value:
                      ref.watch(welcomeNotifier).animationCount[index].value,
                  backgroundColor: AppColors.rexWhite.withOpacity(0.3),
                  color: AppColors.rexWhite,
                ),
              ),
            ),
          ),
        ),
      );
}
