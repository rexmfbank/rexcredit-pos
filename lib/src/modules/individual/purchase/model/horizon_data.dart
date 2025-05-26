import 'dart:math';

import 'package:equatable/equatable.dart';

class HorizonData extends Equatable {
  final String transType;
  final num amount;
  final String colour;
  final String tid;
  final String rrn;
  final String stan;
  final bool print;

  HorizonData({
    required this.transType,
    required this.amount,
    required this.colour,
    required this.tid,
    required this.print,
  })  : rrn = generate12DigitNumber(),
        stan = generate6DigitNumber();

  Map<String, dynamic> toJson() => {
        "transType": transType,
        "amount": amount,
        "colour": colour,
        "TID": tid,
        "rrn": rrn,
        "stan": stan,
        "print": print
      };

  @override
  List<Object?> get props => [
        transType,
        amount,
        colour,
        tid,
        print,
        rrn,
        stan,
      ];
}

String generate12DigitNumber() {
  final Random random = Random();
  // Generate three 4-digit numbers and concatenate them
  String part1 = (1000 + random.nextInt(9000)).toString();
  String part2 = (1000 + random.nextInt(9000)).toString();
  String part3 = (1000 + random.nextInt(9000)).toString();
  return part1 + part2 + part3;
}

String generate6DigitNumber() {
  final Random random = Random();
  // Generate a 6-digit number
  return (100000 + random.nextInt(900000)).toString();
}
