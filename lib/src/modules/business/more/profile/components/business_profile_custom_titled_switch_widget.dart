import 'package:flutter/material.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class CustomTitledSwitchWidget extends StatefulWidget {
  const CustomTitledSwitchWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onChanged,
    this.initialValue = false,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final bool initialValue;
  final void Function(bool) onChanged;

  @override
  State<StatefulWidget> createState() => _CustomTitledSwitchWidgetState();
}

class _CustomTitledSwitchWidgetState extends State<CustomTitledSwitchWidget> {
  bool _value = false;

@override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: AppTextStyles.body1Regular.copyWith(
                  fontSize: 11.asp,
                    color: AppColors.rexTint500,
                ),
              ),
            ],
          ),
          Switch(
            value: _value,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
              });
              widget.onChanged(newValue); // Call the callback function
            },
          ),
        ],
      ),
    );
  }
}
