import 'package:equatable/equatable.dart';

class RequestPOSData extends Equatable {
  final String customerType;
  final String utility;
  final String firstname;

  const RequestPOSData(
      {required this.customerType,
      required this.utility,
      required this.firstname});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
