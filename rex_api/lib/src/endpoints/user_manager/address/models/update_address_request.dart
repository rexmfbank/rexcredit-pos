import 'package:equatable/equatable.dart';

class UpdateAddressRequest extends Equatable {
  final String houseNo;
  final String street;
  final String area;
  final String state;
  final String city;
  final String lga;
  final String country;
  final double longitude;
  final double latitude; 

  const UpdateAddressRequest({
    required this.houseNo,
    required this.street,
    required this.area,
    required this.state,
    required this.city,
    required this.lga,
    required this.country,
    required this.longitude,
    required this.latitude
  });

  Map<String, dynamic> toJson() => {
        "houseNo": houseNo,
        "street": street,
        "area": area,
        "state": state,
        "city": city,
        "lga": lga,
        "country": country,
        "longitude": longitude,
        "latitude": latitude
      };

  @override
  List<Object?> get props => [
        houseNo,
        street,
        area,
        state,
        city,
        lga,
        country,
        longitude,
        latitude
      ];
}
