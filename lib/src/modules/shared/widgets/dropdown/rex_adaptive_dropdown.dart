import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget that displays a dropdown that adapts its look based on
/// the platform. On Android it uses a [DropdownButton] and on iOS
/// it shows a [CupertinoPicker] inside a modal popup.
class RexAdaptiveDropdown<T> extends StatefulWidget {
  /// The list of items to display.
  final List<T> items;

  /// The currently selected item.
  final T? value;

  /// A text to display when no item is selected.
  final String hint;

  /// Callback when the user selects an item.
  final ValueChanged<T?> onChanged;

  /// Optional function to convert an item to a display string.
  final String Function(T)? itemToString;

  const RexAdaptiveDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.itemToString,
  });

  @override
  State<RexAdaptiveDropdown<T>> createState() => _RexAdaptiveDropdownState<T>();
}

class _RexAdaptiveDropdownState<T> extends State<RexAdaptiveDropdown<T>> {
  void _showCupertinoPicker(BuildContext context) {
    // If no item is selected, default to the first.
    final int initialIndex =
        widget.value != null ? widget.items.indexOf(widget.value!) : 0;
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: initialIndex);

    showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            // A "Done" button to close the picker.
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('Done'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController: scrollController,
                itemExtent: 40,
                onSelectedItemChanged: (int index) {
                  // Update selection immediately as user scrolls.
                  widget.onChanged(widget.items[index]);
                },
                children: widget.items.map((T item) {
                  final text = widget.itemToString != null
                      ? widget.itemToString!(item)
                      : item.toString();
                  return Center(child: Text(text));
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use Cupertino styling on iOS.
    if (Platform.isIOS) {
      final String displayText = widget.value != null
          ? (widget.itemToString != null
              ? widget.itemToString!(widget.value!)
              : widget.value.toString())
          : widget.hint;
      return GestureDetector(
        onTap: () => _showCupertinoPicker(context),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: CupertinoColors.separator),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                displayText,
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(
                CupertinoIcons.down_arrow,
                size: 20,
              ),
            ],
          ),
        ),
      );
    }
    // Use Material dropdown on Android (and other platforms).
    return DropdownButton<T>(
      hint: Text(widget.hint),
      value: widget.value,
      items: widget.items.map((T item) {
        final text = widget.itemToString != null
            ? widget.itemToString!(item)
            : item.toString();
        return DropdownMenuItem<T>(
          value: item,
          child: Text(text),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}

/// how to use this adaptive dropdown
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedFruit;
  final List<String> fruits = ['Apple', 'Banana', 'Cherry', 'Date'];

  @override
  Widget build(BuildContext context) {
    return AdaptiveDropdown<String>(
      items: fruits,
      value: selectedFruit,
      hint: 'Select a fruit',
      onChanged: (value) {
        setState(() {
          selectedFruit = value;
        });
      },
    );
  }
}
*/
