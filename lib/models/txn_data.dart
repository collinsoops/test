import 'package:hive/hive.dart';
// part "txn_data.g.dart";

// @HiveType(typeId: 0)
class TxnData {
  // @HiveField(0)
  int txnId;
  // @HiveField(1)
  dynamic service;
  // @HiveField(2)
  dynamic msisdn;
  // @HiveField(3)
  dynamic serviceProvider;
  // @HiveField(4)
  dynamic serviceProviderRef;
  // @HiveField(5)
  dynamic amount;
  // @HiveField(6)
  dynamic desc;
  // @HiveField(9)
  dynamic agentsCommission;
  // @HiveField(10)
  dynamic status;
  // @HiveField(12)
  bool isError;
  // @HiveField(13)
  dynamic token;
  // @HiveField(14)
  dynamic meterNumber;
  // @HiveField(15)
  dynamic msg;
  // @HiveField(16)
  dynamic txnDateTime;
  // @HiveField(18)
  dynamic sender;
  // @HiveField(19)
  dynamic recipient;
  // @HiveField(20)
  dynamic created;
  // @HiveField(21)
  dynamic customerName;

  TxnData({
    this.txnId,
    this.service,
    this.msisdn,
    this.serviceProvider,
    this.serviceProviderRef,
    this.amount,
    this.desc,
    this.status,
    this.token,
    this.meterNumber,
    this.customerName,
    this.isError = false,
    this.msg,
    this.txnDateTime,
    this.sender,
    this.recipient,
    this.created,
  });

  factory TxnData.fromJson(Map json) {
    return TxnData(
        txnId: json["txnId"],
        service: json["service"],
        msisdn: json["msisdn"],
        serviceProvider: json["serviceProvider"],
        serviceProviderRef: json["serviceProviderRef"],
        amount: json["amount"],
        desc: json["desc"],
        status: json["status"],
        isError: json["isError"],
        token: json["token"],
        msg: json["msg"],
        txnDateTime: json["createdAt"],
        sender: json["sender"],
        recipient: json["recipient"],
        created: json["created"],
        customerName: json["customerName"]);
  }
}
