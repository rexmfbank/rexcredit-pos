import 'package:flutter/material.dart';
import 'package:rex_app/src/modules/revamp/utils/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/app_text_styles.dart';
import 'package:rex_app/src/utils/constants/constants.dart';
import 'package:rex_app/src/utils/extensions/extension_on_object.dart';

class RexCustomSpinner extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final String title;
  final String? hint;
  final EdgeInsets? padding;
  final void Function(String?)? onOptionChanged; // Callback function

  const RexCustomSpinner({
    Key? key,
    required this.options,
    required this.title,
    this.selectedOption,
    this.padding,
    this.hint,
    this.onOptionChanged, // Provide the callback function as a parameter
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomSpinnerState();
}

class _CustomSpinnerState extends State<RexCustomSpinner> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = selectedOption.isNotNull
        ? selectedOption
        : widget.options.isNotEmpty
            ? widget.options[0]
            : null; // Initialize selectedOption as null, consider this
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16.aw),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 15.asp,
                fontWeight: FontWeight.w500,
                color: AppColors.rexPurpleDark,
              ),
            ),
          ),
          SizedBox(height: 10.ah),
          DropdownButtonFormField<String>(
            value: selectedOption,
            hint: widget.hint == null
                ? null
                : Text(
                    widget.hint!,
                    style: AppTextStyles.body1Regular.copyWith(
                      fontSize: 10.asp,
                      color: AppColors.textGreyLight,
                    ),
                  ),
            style: AppTextStyles.body1Regular.copyWith(
              fontSize: 13.asp,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(15),
              filled: true,
              fillColor: AppColors.rexWhite,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (newValue) {
              setState(() {
                selectedOption = newValue!;
                widget.onOptionChanged
                    ?.call(newValue); // Invoke the callback function
              });
            },
            items: [
              const DropdownMenuItem<String>(
                // value:
                //     'Select an option', // Set the value of the hint text as null
                child: Text(
                  'Select an option',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              ...widget.options.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: SizedBox(
                    width: 250.aw,
                    child: Text(
                      option.split("//")[0],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }
}

// class RexCustomSpinnerTf extends StatefulWidget {
//   final options;
//   final String title;
//   final void Function(String?)? onOptionChanged; // Callback function

//   const RexCustomSpinnerTf({
//     Key? key,
//     required this.options,
//     required this.title,
//     this.onOptionChanged, // Provide the callback function as a parameter
//   }) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _CustomSpinnerTfState();
// }

// class _CustomSpinnerTfState extends State<RexCustomSpinnerTf> {
//   String? selectedOption;

//   @override
//   void initState() {
//     super.initState();
//     selectedOption = null; // Initialize selectedOption as null
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         top: 24.0,
//         bottom: 2.0,
//         left: 16.0,
//         right: 16.0,
//       ),
//       child: Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               widget.title,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.rexPurpleDark,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           DropdownButtonFormField<String>(
//             value: selectedOption,
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.all(15),
//               filled: true,
//               fillColor: AppColors.rexWhite,
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: Colors.transparent),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             onChanged: (newValue) {
//               setState(() {
//                 selectedOption = newValue!;
//                 widget.onOptionChanged
//                     ?.call(newValue); // Invoke the callback function
//               });
//             },
//             items: [
//               const DropdownMenuItem<String>(
//                 value:
//                     'Select an option', // Set the value of the hint text as null
//                 child: Text(
//                   'Select an option',
//                   style: TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
//               ...widget.options.map((option) {
//                 return DropdownMenuItem(
//                   value: "${option.name}/${option.code}",
//                   child: Text("${option.name}"),
//                 );
//               }).toList(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//}
