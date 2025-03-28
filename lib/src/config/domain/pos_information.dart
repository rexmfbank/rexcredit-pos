import 'dart:convert';

class PosInformation {
  final String? bankName;
  final String? location;
  final String? footerMessage;
  final String? merchantID;
  final String? pTSP;
  final String? serialNumber;
  final String? billerId;
  final String? terminalId;
  final String? baseAppVersion;

  const PosInformation({
    this.bankName,
    this.location,
    this.footerMessage,
    this.merchantID,
    this.pTSP,
    this.serialNumber,
    this.billerId,
    this.terminalId,
    this.baseAppVersion,
  });

  factory PosInformation.fromMap(Map<String, dynamic> map) {
    return PosInformation(
      bankName: map['BankName'],
      location: map['Location'],
      footerMessage: map['FooterMessage'],
      merchantID: map['MerchantID'],
      pTSP: map['PTSP'],
      serialNumber: map['serialNumber'],
      billerId: map['BillerId'],
      terminalId: map['TerminalID'],
      baseAppVersion: map['baseAppVersion'],
    );
  }

  static PosInformation posInformationFromMap(String? str) =>
      PosInformation.fromMap(json.decode(str ?? ''));
}
