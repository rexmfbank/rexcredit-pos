import 'package:equatable/equatable.dart';

class AddressDto extends Equatable {
  final String houseNumber;
  final String street;
  final String area;
  final String state;
  final String city;
  final String lga;
  final String country;
  final int longitude;
  final int latitude;

  const AddressDto({
    required this.houseNumber,
    required this.street,
    required this.area,
    required this.state,
    required this.city,
    required this.lga,
    required this.country,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() => {
        "houseNo": houseNumber,
        "street": street,
        "area": area,
        "state": state,
        "city": city,
        "lga": lga,
        "country": country,
        "longitude": longitude,
        "latitude": latitude,
      };

  @override
  String toString() => {
        "CLASS": "Address",
        "houseNo": houseNumber,
        "street": street,
        "area": area,
        "state": state,
        "city": city,
        "lga": lga,
        "country": country,
        "longitude": longitude,
        "latitude": latitude,
      }.toString();

  @override
  List<Object?> get props => [
        houseNumber,
        street,
        area,
        state,
        city,
        lga,
        country,
        longitude,
        latitude,
      ];
}
