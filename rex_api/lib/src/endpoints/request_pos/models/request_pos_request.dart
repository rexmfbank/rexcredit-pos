import 'package:equatable/equatable.dart';
import 'package:rex_api/rex_api.dart';

class RequestPOSRequest extends Equatable {
  final List<AddDirectorsRequestData>? directors;
  final String customerType;
  final String accountNumber;
  final String? utility;
  final String username;
  final String entityCode;
  final String? phoneNumber;
  final String emailAddress;
  final String? businessCode;
  final String? cacDocument;
  final String? bvn;
  final String? nin;
  final String mobileNumber;
  final String contactPerson;
  final String lineOfBusiness;
  final String bankName;
  final String? bankCode;
  final String accountName;
  final String address;

  const RequestPOSRequest(
      {this.directors,
      required this.customerType,
      required this.accountNumber,
      this.utility,
      required this.username,
      required this.entityCode,
      this.phoneNumber,
      required this.emailAddress,
      this.businessCode,
      this.cacDocument,
      this.bvn,
      this.nin,
      required this.mobileNumber,
      required this.contactPerson,
      required this.lineOfBusiness,
      required this.bankName,
      this.bankCode,
      required this.accountName,
      required this.address});

  Map<String, dynamic> toJson() => {
        "directors": directors,
        "customerType": customerType,
        "accountNumber": accountNumber,
        "utility": utility,
        "username": username,
        "entityCode": entityCode,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "businessCode": businessCode,
        "cacDocument": cacDocument,
        "bvn": bvn,
        "nin": nin,
        "mobileNumber": mobileNumber,
        "contactPerson": contactPerson,
        "lineOfBusiness": lineOfBusiness,
        "bankName": bankName,
        "bankCode": bankCode,
        "accountName": accountName,
        "address": address
      };

  @override
  String toString() => {
        "directors": directors,
        "customerType": customerType,
        "accountNumber": accountNumber,
        "utility": utility,
        "username": username,
        "entityCode": entityCode,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "businessCode": businessCode,
        "cacDocument": cacDocument,
        "bvn": bvn,
        "nin": nin,
        "mobileNumber": mobileNumber,
        "contactPerson": contactPerson,
        "lineOfBusiness": lineOfBusiness,
        "bankName": bankName,
        "bankCode": bankCode,
        "accountName": accountName,
        "address": address
      }.toString();

  @override
  List<Object?> get props => [
        directors,
        customerType,
        accountNumber,
        utility,
        username,
        entityCode,
        phoneNumber,
        emailAddress,
        businessCode,
        cacDocument,
        bvn,
        nin,
        mobileNumber,
        lineOfBusiness,
        bankCode,
        bankName,
        accountName,
        address
      ];
}
