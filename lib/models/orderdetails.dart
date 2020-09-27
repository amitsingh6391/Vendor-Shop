// To parse this JSON data, do
//
//     final oredrDetails = oredrDetailsFromJson(jsonString);

import 'dart:convert';

OredrDetails oredrDetailsFromJson(String str) =>
    OredrDetails.fromJson(json.decode(str));

String oredrDetailsToJson(OredrDetails data) => json.encode(data.toJson());

class OredrDetails {
  OredrDetails({
    this.result,
    this.transactions,
  });

  String result;
  List<Transaction> transactions;

  factory OredrDetails.fromJson(Map<String, dynamic> json) => OredrDetails(
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
    this.itemName,
    this.itemImg,
    this.qty,
    this.amount,
    this.totalAmount,
  });

  String itemName;
  String itemImg;
  String qty;
  int amount;
  String totalAmount;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        itemName: json["item_name"],
        itemImg: json["item_img"],
        qty: json["qty"],
        amount: json["amount"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_img": itemImg,
        "qty": qty,
        "amount": amount,
        "total_amount": totalAmount,
      };
}

// To parse this JSON data, do
//
//     final oredrconfirmation = oredrconfirmationFromJson(jsonString);

Oredrconfirmation oredrconfirmationFromJson(String str) =>
    Oredrconfirmation.fromJson(json.decode(str));

String oredrconfirmationToJson(Oredrconfirmation data) =>
    json.encode(data.toJson());

class Oredrconfirmation {
  Oredrconfirmation({
    this.result,
  });

  String result;

  factory Oredrconfirmation.fromJson(Map<String, dynamic> json) =>
      Oredrconfirmation(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
