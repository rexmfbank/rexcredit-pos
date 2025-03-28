import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the LineItem class representing a line item
class LineItem extends Equatable {
  final String title;
  final double amount;
  final int quantity;
  final double taxTotal;

  const LineItem({
    required this.title,
    required this.amount,
    required this.quantity,
    required this.taxTotal,
  });

  @override
  List<Object?> get props => [
        title,
        amount,
        quantity,
        taxTotal,
      ];
}

// Define the provider for line items using StateProvider

final lineItemProvider = NotifierProvider<LineItemNotifier, List<LineItem>>(() {
  return LineItemNotifier();
});

class LineItemNotifier extends Notifier<List<LineItem>> {
  void addLineItem(LineItem item) {
    state = [...state, item];
  }

  @override
  List<LineItem> build() {
    return [];
  }
}
