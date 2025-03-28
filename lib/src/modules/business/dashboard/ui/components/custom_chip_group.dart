import 'package:flutter/material.dart';

class ChipGroupExample extends StatefulWidget {
  @override
  _ChipGroupExampleState createState() => _ChipGroupExampleState();
}

class _ChipGroupExampleState extends State<ChipGroupExample> {
  List<String> selectedChips = [];

  void handleChipSelection(String chipLabel, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedChips.add(chipLabel);
      } else {
        selectedChips.remove(chipLabel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: <Widget>[
        ChipWidget(
          label: 'All',
          isSelected: selectedChips.contains('Chip 1'),
          onSelected: handleChipSelection,
        ),
        ChipWidget(
          label: 'Top Up',
          isSelected: selectedChips.contains('Chip 2'),
          onSelected: handleChipSelection,
        ),
        ChipWidget(
          label: 'Transfer',
          isSelected: selectedChips.contains('Chip 3'),
          onSelected: handleChipSelection,
        ),
        ChipWidget(
          label: 'Virtual Debit Card',
          isSelected: selectedChips.contains('Chip 3'),
          onSelected: handleChipSelection,
        ),
        // Add more ChipWidgets as needed
      ],
    );
  }
}

class ChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(String, bool) onSelected;

  const ChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (isSelected) => onSelected(label, isSelected),
      selectedColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Theme.of(context).chipTheme.backgroundColor,
      labelStyle:
          TextStyle(color: Theme.of(context).chipTheme.labelStyle?.color),
    );
  }
}
