// To parse this JSON data, do
//
//     final pendingOrders = pendingOrdersFromJson(jsonString);

import 'dart:convert';

PendingOrders pendingOrdersFromJson(String str) => PendingOrders.fromJson(json.decode(str));

String pendingOrdersToJson(PendingOrders data) => json.encode(data.toJson());

class PendingOrders {
    PendingOrders({
        this.result,
        this.transactions,
    });

    String result;
    List<Transaction> transactions;

    factory PendingOrders.fromJson(Map<String, dynamic> json) => PendingOrders(
        result: json["result"],
        transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
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
