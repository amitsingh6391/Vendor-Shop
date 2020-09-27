// To parse this JSON data, do
//
//     final allOrders = allOrdersFromJson(jsonString);

import 'dart:convert';

AllOrders allOrdersFromJson(String str) => AllOrders.fromJson(json.decode(str));

String allOrdersToJson(AllOrders data) => json.encode(data.toJson());

class AllOrders {
  AllOrders({
    this.result,
    this.transactions,
  });

  String result;
  List<Transaction> transactions;

  factory AllOrders.fromJson(Map<String, dynamic> json) => AllOrders(
        result: json["result"],
        transactions: List<Transaction>.from(
            json["transactions"].map((x) => Transaction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
      };
}

class Transaction {
  Transaction({
    this.date,
    this.time,
    this.username,
    this.totalAmount,
    this.deliveryboyName,
  });

  String date;
  String time;
  String username;
  String totalAmount;
  String deliveryboyName;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        date: json["date"],
        time: json["time"],
        username: json["username"],
        totalAmount: json["total_amount"],
        deliveryboyName: json["deliveryboy_name"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "username": username,
        "total_amount": totalAmount,
        "deliveryboy_name": deliveryboyName,
      };
}
