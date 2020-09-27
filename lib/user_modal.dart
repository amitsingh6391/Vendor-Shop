// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.vendorUid,
    this.result,
    this.vendorName,
    this.vendorMobile,
    this.vendorEmail,
    this.vendorType,
    this.hotelUid,
    this.hotelName,
    this.hotelMobile,
    this.hotelPhone,
    this.hotelMail,
    this.hotelLogo,
  });

  String vendorUid;
  String result;
  String vendorName;
  String vendorMobile;
  String vendorEmail;
  String vendorType;
  String hotelUid;
  String hotelName;
  String hotelMobile;
  String hotelPhone;
  String hotelMail;
  String hotelLogo;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        vendorUid: json["vendor_uid"],
        result: json["result"],
        vendorName: json["vendor_name"],
        vendorMobile: json["vendor_mobile"],
        vendorEmail: json["vendor_email"],
        vendorType: json["vendor_type"],
        hotelUid: json["hotel_uid"],
        hotelName: json["hotel_name"],
        hotelMobile: json["hotel_mobile"],
        hotelPhone: json["hotel_phone"],
        hotelMail: json["hotel_mail"],
        hotelLogo: json["hotel_logo"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_uid": vendorUid,
        "result": result,
        "vendor_name": vendorName,
        "vendor_mobile": vendorMobile,
        "vendor_email": vendorEmail,
        "vendor_type": vendorType,
        "hotel_uid": hotelUid,
        "hotel_name": hotelName,
        "hotel_mobile": hotelMobile,
        "hotel_phone": hotelPhone,
        "hotel_mail": hotelMail,
        "hotel_logo": hotelLogo,
      };
}
