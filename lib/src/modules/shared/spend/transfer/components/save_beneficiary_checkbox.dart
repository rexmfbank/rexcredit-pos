import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/string_assets.dart';

class AddBeneficiaryCheckbox extends StatefulHookConsumerWidget {
  final ValueNotifier<bool> isSavedNotifier;
  final ValueChanged<bool>? onCheckboxChanged;

  const AddBeneficiaryCheckbox({
    super.key,
    required this.isSavedNotifier,
    this.onCheckboxChanged,
  });

  @override
  ConsumerState<StatefulHookConsumerWidget> createState() =>
      _AddBeneficiaryCheckbox();
}

class _AddBeneficiaryCheckbox extends ConsumerState<AddBeneficiaryCheckbox> {
  @override
  Widget build(BuildContext context) {
    final isSaved = useValueListenable(widget.isSavedNotifier);

    return Row(
      children: [
        Checkbox(
          value: isSaved,
          onChanged: (value) {
            widget.isSavedNotifier.value = value ?? false;
            widget.onCheckboxChanged?.call(value ?? false);
          },
          activeColor: AppColors.rexPurpleLight,
        ),
        Text(
          StringAssets.saveThisBeneficiary,
          style: TextStyle(
            color: isSaved ? AppColors.rexPurpleDark : Colors.grey,
          ),
        ),
      ],
    );
  }
}
