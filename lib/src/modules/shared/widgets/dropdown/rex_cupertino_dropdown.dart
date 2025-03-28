import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rex_app/src/config/theme/app_colors.dart';
import 'package:rex_app/src/utils/constants/constants.dart';

class RexCupertinoDropdown extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String?>? onChanged;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Color? dropIconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? dropDownTextColor;
  final Color? textColor;
  final String? dropdownValue;
  final bool withHint;
  final double? height;
  final double? borderWidth;
  final double? paddingWidth;

  const RexCupertinoDropdown({
    super.key,
    required this.items,
    this.hintText,
    this.onChanged,
    required this.dropdownValue,
    this.dropIconColor,
    this.backgroundColor,
    this.dropDownTextColor,
    this.borderColor,
    this.textColor,
    this.height,
    this.borderWidth,
    this.paddingWidth,
    this.hintStyle,
    this.style,
    this.withHint = true,
  }) : assert(!withHint || (withHint && hintText != null),
            'hint text shouldn\'t be null if withHint is true');

  @override
  State<RexCupertinoDropdown> createState() => _RexCupertinoDropdownState();
}

class _RexCupertinoDropdownState extends State<RexCupertinoDropdown> {
  late final ValueNotifier<String?> dropdownValueNotifier =
      ValueNotifier(widget.dropdownValue);

  @override
  void didUpdateWidget(covariant RexCupertinoDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    dropdownValueNotifier.value = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.onChanged == null) return;
        dropdownValueNotifier.value = await _showPicker(
          context,
          widget.items,
          dropdownValueNotifier.value,
        );
        widget.onChanged!(dropdownValueNotifier.value);
      },
      child: Container(
        height: widget.height ?? 66.ah,
        padding:
            EdgeInsets.symmetric(horizontal: widget.paddingWidth ?? 16.0.aw),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: widget.borderWidth ?? 0.5,
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.ah),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.withHint)
                      ValueListenableBuilder(
                          valueListenable: dropdownValueNotifier,
                          builder: (context, String? value, child) {
                            if (value == null) {
                              return const SizedBox.shrink();
                            }
                            return Text(
                              widget.hintText!,
                              style: widget.hintStyle ??
                                  TextStyle(
                                    fontSize: 12.asp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textBlack,
                                  ),
                              textAlign: TextAlign.start,
                            );
                          }),
                    SizedBox(height: 3.ah),
                    ValueListenableBuilder(
                      valueListenable: dropdownValueNotifier,
                      builder: (context, String? value, child) {
                        return Text(
                          value ?? widget.hintText ?? '',
                          style: value == null
                              ? widget.style ??
                                  TextStyle(
                                    color:
                                        widget.textColor ?? AppColors.textBlack,
                                    fontSize: 15.asp,
                                    fontWeight: FontWeight.w400,
                                  )
                              : widget.style ??
                                  TextStyle(
                                    fontSize: 15.asp,
                                    fontWeight: FontWeight.w700,
                                    color: widget.dropDownTextColor ??
                                        Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.color,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.start,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 24.ar,
                color: widget.dropIconColor ?? AppColors.textBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showPicker(
    BuildContext ctx,
    List<String> items,
    String? dropdownValue,
  ) async {
    //String? dropdownValue;
    int valueIndex;
    if (dropdownValue == null) {
      valueIndex = -1;
    } else {
      valueIndex = items.indexOf(dropdownValue);
    }
    return await showCupertinoModalBottomSheet(
      context: ctx,
      builder: (_) {
        return CupertinoActionSheet(
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.textBlack,
                        width: 0.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CupertinoButton(
                        onPressed: () {
                          Navigator.pop(
                            ctx,
                            dropdownValue ??
                                items[valueIndex == -1 ? 0 : valueIndex],
                          );
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.asp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: AppConstants.deviceWidth,
                  height: 200.ah,
                  child: CupertinoPicker(
                    useMagnifier: false,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: AppColors.silverGrey.withOpacity(0.2),
                    ),
                    backgroundColor: Colors.white,
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                      initialItem: valueIndex == -1 ? 0 : valueIndex,
                    ),
                    onSelectedItemChanged: (value) {
                      setState(() {
                        dropdownValue = items[value];
                      });
                    },
                    children: items.map((String value) {
                      return Center(
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 25.asp,
                            color: widget.dropDownTextColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
