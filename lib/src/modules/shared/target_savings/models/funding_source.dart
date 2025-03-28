enum FundingSource {
  card(name: 'CARD'),
  account(name: 'ACCOUNT');

  const FundingSource({required this.name});

  final String name;
}

enum TransferType {
  credit(letter: 'C'),
  debit(letter: 'D');

  const TransferType({required this.letter});

  final String letter;
}
