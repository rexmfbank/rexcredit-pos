import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/utils/theme/app_colors.dart';
import 'package:rex_app/src/modules/utils/general/constants.dart';

/// A reusable pill-style tab view widget.
///
/// Accepts a list of [tabLabels] and their corresponding [tabViews].
/// Can be used on any screen that needs a simple tab switcher.
class RexTabView extends StatefulWidget {
  const RexTabView({
    super.key,
    required this.tabLabels,
    required this.tabViews,
    this.initialIndex = 0,
    this.onTabChanged,
  }) : assert(
         tabLabels.length == tabViews.length,
         'tabLabels and tabViews must have the same length',
       );

  /// The labels displayed on each tab.
  final List<String> tabLabels;

  /// The content widget shown for each tab.
  final List<Widget> tabViews;

  /// The initially selected tab index.
  final int initialIndex;

  /// Called when the selected tab changes.
  final ValueChanged<int>? onTabChanged;

  @override
  State<RexTabView> createState() => _RexTabViewState();
}

class _RexTabViewState extends State<RexTabView> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab bar
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.ar),
            border: Border.all(color: AppColors.rexWhite),
          ),
          child: Row(
            children: List.generate(widget.tabLabels.length, (index) {
              final isSelected = _selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    widget.onTabChanged?.call(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.rexPurpleLight
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.tabLabels[index],
                      style: TextStyle(
                        fontSize: 14.asp,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? AppColors.rexWhite
                                : AppColors.rexPurpleDark,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 24.ah),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: widget.tabViews[_selectedIndex],
        ),
      ],
    );
  }
}
