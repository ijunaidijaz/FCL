// To parse this JSON data, do
//
//     final paymentResponseDatamodel = paymentResponseDatamodelFromJson(jsonString);

import 'dart:convert';

PaymentResponseDatamodel paymentResponseDatamodelFromJson(String str) =>
    PaymentResponseDatamodel.fromJson(json.decode(str));

String paymentResponseDatamodelToJson(PaymentResponseDatamodel data) =>
    json.encode(data.toJson());

class PaymentResponseDatamodel {
  PaymentResponseDatamodel({
    this.createdDt,
    this.orderNo,
    this.invId,
    this.hash,
    this.custName,
    this.custEmail,
    this.custMobile,
    this.orderAmt,
    this.deliveryCharges,
    this.totalItems,
    this.remarks,
    this.callbackUrl,
    this.invoiceType,
    this.status,
    this.txInfo,
  });

  String createdDt;
  String orderNo;
  String invId;
  String hash;
  String custName;
  String custEmail;
  String custMobile;
  String orderAmt;
  String deliveryCharges;
  String totalItems;
  String remarks;
  String callbackUrl;
  String invoiceType;
  String status;
  TxInfo txInfo;

  factory PaymentResponseDatamodel.fromJson(Map<String, dynamic> json) =>
      PaymentResponseDatamodel(
        createdDt: json["created_dt"],
        orderNo: json["order_no"],
        invId: json["inv_id"],
        hash: json["hash"],
        custName: json["cust_name"],
        custEmail: json["cust_email"],
        custMobile: json["cust_mobile  "],
        orderAmt: json["order_amt"],
        deliveryCharges: json["delivery_charges"],
        totalItems: json["total_items"],
        remarks: json["remarks"],
        callbackUrl: json["callback_url"],
        invoiceType: json["invoice_type"],
        status: json["status"],
        txInfo: TxInfo.fromJson(json["TxInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "created_dt": createdDt,
        "order_no": orderNo,
        "inv_id": invId,
        "hash": hash,
        "cust_name": custName,
        "cust_email": custEmail,
        "cust_mobile  ": custMobile,
        "order_amt": orderAmt,
        "delivery_charges": deliveryCharges,
        "total_items": totalItems,
        "remarks": remarks,
        "callback_url": callbackUrl,
        "invoice_type": invoiceType,
        "status": status,
        "TxInfo": txInfo.toJson(),
      };
}

class TxInfo {
  TxInfo({
    this.txId,
    this.amt,
    this.type,
    this.paymentId,
    this.result,
    this.postDate,
    this.tranId,
    this.auth,
    this.ref,
    this.trackId,
    this.udf1,
    this.udf2,
    this.udf3,
    this.udf4,
    this.udf5,
    this.txStatus,
    this.txDt,
  });

  String txId;
  String amt;
  String type;
  String paymentId;
  String result;
  String postDate;
  String tranId;
  String auth;
  String ref;
  String trackId;
  String udf1;
  String udf2;
  String udf3;
  dynamic udf4;
  dynamic udf5;
  String txStatus;
  String txDt;

  factory TxInfo.fromJson(Map<String, dynamic> json) => TxInfo(
        txId: json["tx_id"],
        amt: json["amt"],
        type: json["type"],
        paymentId: json["PaymentID"],
        result: json["Result"],
        postDate: json["PostDate"],
        tranId: json["TranID"],
        auth: json["Auth"],
        ref: json["Ref"],
        trackId: json["TrackID"],
        udf1: json["UDF1"],
        udf2: json["UDF2"],
        udf3: json["UDF3"],
        udf4: json["UDF4"],
        udf5: json["UDF5"],
        txStatus: json["tx_status"],
        txDt: json["tx_dt"],
      );

  Map<String, dynamic> toJson() => {
        "tx_id": txId,
        "amt": amt,
        "type": type,
        "PaymentID": paymentId,
        "Result": result,
        "PostDate": postDate,
        "TranID": tranId,
        "Auth": auth,
        "Ref": ref,
        "TrackID": trackId,
        "UDF1": udf1,
        "UDF2": udf2,
        "UDF3": udf3,
        "UDF4": udf4,
        "UDF5": udf5,
        "tx_status": txStatus,
        "tx_dt": txDt,
      };
}
