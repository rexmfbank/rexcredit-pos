import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class AccountTypeTile extends ConsumerStatefulWidget {
  const AccountTypeTile({
    super.key,
    required this.onChanged,
    required this.isChecked,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.kycText,
  });

  final void Function(bool?)? onChanged;
  final bool? isChecked;
  final String title;
  final String subtitle;
  final String imagePath;
  final String kycText;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AccountTypeTile2State();
}

class _AccountTypeTile2State extends ConsumerState<AccountTypeTile> {
  bool tileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
        expandedAlignment: Alignment.center,
        title: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: widget.isChecked,
          title: Text(
            widget.title,
            style: TextStyle(
              fontSize: 16.asp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(widget.subtitle),
          onChanged: widget.onChanged,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            tileExpanded = expanded;
          });
        },
        childrenPadding: const EdgeInsets.all(8.0),
        collapsedTextColor: AppColors.rexPurpleDark,
        collapsedIconColor: AppColors.rexPurpleDark,
        textColor: AppColors.rexPurpleDark,
        iconColor: AppColors.rexPurpleDark,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.aw, vertical: 8.ah),
            child: Text(
              widget.kycText,
              style: const TextStyle(color: AppColors.rexPurpleDark),
            ),
          ),
        ],
      ),
    );
  }
}

/**
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Expanded(
            child: CheckboxListTile(
              value: widget.isChecked,
              title: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 16.asp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(widget.subtitle),
              onChanged: widget.onChanged,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            ),
          ),
          widget.isChecked != null && widget.isChecked!
              ? Flexible(
                  child: Text(
                    widget.kycText,
                    style: const TextStyle(color: AppColors.rexPurpleDark),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
 */