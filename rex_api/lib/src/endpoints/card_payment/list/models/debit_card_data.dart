import 'package:equatable/equatable.dart';

class DebitCardData extends Equatable {
  final int id;
  final String? cardName;
  final String brand;
  final String maskedPan;
  final String expiryDate;
  final String createdDate;
  bool isSelected;

  DebitCardData({
    required this.id,
    required this.cardName,
    required this.brand,
    required this.maskedPan,
    required this.expiryDate,
    required this.createdDate,
    this.isSelected = false,
  });

  DebitCardData.empty()
      : id = 0,
        cardName = null,
        brand = '',
        maskedPan = '',
        expiryDate = '',
        createdDate = '',
        isSelected = false;

  factory DebitCardData.fromJson(Map<String, dynamic> json) {
    return DebitCardData(
      id: json['id'] as int,
      cardName: json['cardName'] as String?,
      brand: json['brand'] as String,
      maskedPan: json['maskedPan'] as String,
      expiryDate: json['expiryDate'] as String,
      createdDate: json['createdDate'] as String,
    );
  }

  @override
  String toString() => {
        "CLASS": "DebitCardData",
        "id": id,
        "cardName": cardName,
        "brand": brand,
        "maskedPan": maskedPan,
        "expiryDate": expiryDate,
        "createdDate": createdDate,
        "selected": isSelected,
      }.toString();

  @override
  List<Object?> get props => [
        id,
        cardName,
        brand,
        maskedPan,
        expiryDate,
        createdDate,
        isSelected,
      ];
}
