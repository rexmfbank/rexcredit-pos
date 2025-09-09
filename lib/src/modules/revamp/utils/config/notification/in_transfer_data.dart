import 'package:equatable/equatable.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class InTransferPayload extends Equatable {
  final String channelName;
  final String eventName;
  final InTransferDataWrapper data;
  final String userId;

  const InTransferPayload({
    required this.channelName,
    required this.eventName,
    required this.data,
    required this.userId,
  });

  factory InTransferPayload.fromJson(Map<String, dynamic> json) =>
      InTransferPayload(
        channelName: json['channelName'],
        eventName: json['eventName'],
        data: InTransferDataWrapper.fromJson(
          json['data'] as Map<String, dynamic>,
        ),
        userId: json['userId'],
      );

  Map<String, dynamic> toJson() => {
    'channelName': channelName,
    'eventName': eventName,
    'data': data.toJson(),
    'userId': userId,
  };

  @override
  List<Object?> get props => [channelName, eventName, data, userId];
}

class InTransferDataWrapper extends Equatable {
  final NotificationTransaction transaction;
  final InTransferData transferData;

  const InTransferDataWrapper({
    required this.transaction,
    required this.transferData,
  });

  factory InTransferDataWrapper.fromJson(Map<String, dynamic> json) =>
      InTransferDataWrapper(
        transaction: NotificationTransaction.fromJson(
          json['transaction'] as Map<String, dynamic>,
        ),
        transferData: InTransferData.fromJson(
          json['transferData'] as Map<String, dynamic>,
        ),
      );

  Map<String, dynamic> toJson() => {
    'transaction': transaction.toJson(),
    'transferData': transferData.toJson(),
  };

  @override
  List<Object?> get props => [transaction, transferData];
}

class NotificationTransaction extends Equatable {
  final String message;
  final String accountNo;
  final String amount;

  const NotificationTransaction({
    required this.message,
    required this.accountNo,
    required this.amount,
  });

  factory NotificationTransaction.fromJson(Map<String, dynamic> json) =>
      NotificationTransaction(
        message: json['message'],
        accountNo: json['accountNo'],
        amount: json['amount'],
      );

  Map<String, dynamic> toJson() => {
    'message': message,
    'accountNo': accountNo,
    'amount': amount,
  };

  @override
  List<Object?> get props => [message, accountNo, amount];
}

PosTransactionsResponseData modelNotiftoUIModel(InTransferData transferData) {
  return PosTransactionsResponseData(
    tranCode: transferData.tranCode,
    tranType: transferData.tranType,
    tranUniqRefNo: "${transferData.tranUniqRefNo}",
    tranRefNo: '',
    tranDesc: transferData.narration,
    amount: double.parse(transferData.amount),
    responseCode: '',
    responseMessage: '',
    cbaReferenceNo: '',
    paymentRspCode: '',
    paymentRspMsg: '',
    paymentRefNo: '',
    currencyCode: '',
    narration: transferData.narration,
    beneficiaryBank: transferData.beneficiaryBank,
    beneficiaryAccountNo: transferData.beneficiaryAccountNo,
    sourceAccount: '',
    tranDate: transferData.tranDate,
    beneficiaryBankCode: '',
    beneficiaryName: transferData.beneficiaryName,
    token: '',
    sessionId: transferData.sessionId,
    status: transferData.status,
    senderName: transferData.senderName,
    paymentStatus: transferData.status,
    aid: '',
    crDr: '',
    merchantName: '',
    rrn: '',
    stan: '',
    terminalId: '',
    merchantId: '',
    senderAccountNumber: transferData.senderAccountNumber,
  );
}

class InTransferData extends Equatable {
  final String amount;
  final String tranCode;
  final String tranType;
  final int tranUniqRefNo;
  final String narration;
  final String beneficiaryBank;
  final String beneficiaryAccountNo;
  final String tranDate;
  final String beneficiaryName;
  final String sessionId;
  final String status;
  final String senderName;
  final String senderAccountNumber;

  const InTransferData({
    required this.amount,
    required this.tranCode,
    required this.tranType,
    required this.tranUniqRefNo,
    required this.narration,
    required this.beneficiaryBank,
    required this.beneficiaryAccountNo,
    required this.tranDate,
    required this.beneficiaryName,
    required this.sessionId,
    required this.status,
    required this.senderName,
    required this.senderAccountNumber,
  });

  factory InTransferData.fromJson(Map<String, dynamic> json) => InTransferData(
    amount: json['amount'],
    tranCode: json['tranCode'],
    tranType: json['tranType'],
    tranUniqRefNo: json['tranUniqRefNo'],
    narration: json['narration'],
    beneficiaryBank: json['beneficiaryBank'],
    beneficiaryAccountNo: json['beneficiaryAccountNo'],
    tranDate: json['tranDate'],
    beneficiaryName: json['beneficiaryName'],
    sessionId: json['sessionId'],
    status: json['status'],
    senderName: json['senderName'],
    senderAccountNumber: json['senderAccountNumber'],
  );

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'tranCode': tranCode,
    'tranType': tranType,
    'tranUniqRefNo': tranUniqRefNo,
    'narration': narration,
    'beneficiaryBank': beneficiaryBank,
    'beneficiaryAccountNo': beneficiaryAccountNo,
    'tranDate': tranDate,
    'beneficiaryName': beneficiaryName,
    'sessionId': sessionId,
    'status': status,
    'senderName': senderName,
    'senderAccountNumber': senderAccountNumber,
  };

  @override
  String toString() => "InTransferData:: ${toJson()}";

  @override
  List<Object?> get props => [
    amount,
    tranCode,
    tranType,
    tranUniqRefNo,
    narration,
    beneficiaryBank,
    beneficiaryAccountNo,
    tranDate,
    beneficiaryName,
    sessionId,
    status,
    senderName,
    senderAccountNumber,
  ];
}
