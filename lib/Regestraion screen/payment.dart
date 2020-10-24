import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/Regestraion%20screen/step123screen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class Payment extends StatefulWidget {
  String vendor_mobile,
      vendor_password,
      vendor_email,
      vendor_name,
      hotel_name,
      hotel_mobile,
      hotel_phone,
      hotel_email;

  var otp;

  Payment({
    @required this.otp,
    @required this.vendor_mobile,
    @required this.vendor_password,
    @required this.vendor_email,
    @required this.vendor_name,
    @required this.hotel_name,
    @required this.hotel_mobile,
    @required this.hotel_phone,
    @required this.hotel_email,
  });
  //
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Razorpay razorpay;
  TextEditingController coinEditingController = new TextEditingController();
  int x;
  String y;
  String package;

  String trans_id;
  @override
  void initState() {
    print(widget.otp);
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_TjJecZ7MfB9igy",
      "amount": x * 100,
      "description": "Treato",
      "prefill": {
        "contact": widget.vendor_mobile,
        "email": widget.vendor_email
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
      msg: "Your Payment is Successfull",
      fontSize: 20,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );

    print("Pamyent successful");
    setState(() {
      trans_id = response.paymentId;
      print(trans_id);
    });

    otpmatch(context);
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Fluttertoast.showToast(
      msg: "error" + response.code.toString() + "." + response.message,
      fontSize: 20,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(
      msg: "External Wallet" + response.walletName,
      fontSize: 30,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  otpmatch(BuildContext context) async {
    if (widget.otp != null) {
      String apiUrl = "https://treato.co.in/api/vendor/otp_verify/";

      var map = Map<String, dynamic>();
      map["vendor_name"] = widget.vendor_name;
      map["vendor_mobile"] = widget.vendor_mobile;
      map["vendor_password"] = widget.vendor_password;
      map["vendor_email"] = widget.vendor_email;
      map["hotel_name"] = widget.vendor_name;
      map["hotel_mobile"] = widget.hotel_mobile;
      map["hotel_phone"] = widget.hotel_phone;
      map["hotel_email"] = widget.hotel_email;
      map["otp"] = widget.otp.toString();
      map["payment_amt"] = y;
      map["trans_id"] = trans_id;
      map["package"] = package;
      print("yaaa");
      print(trans_id);
      final response = await http.post(apiUrl, body: map);

      print(response.statusCode);

      Map data;
      data = json.decode(response.body);
      String z = data["result"];

      print(data["result"]);
      print(response.statusCode);

      if (response.statusCode == 200 && z == "Success") {
        var hotel_ui = data["hotel_uid"];
        print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Step2(
                      hotel_uid: hotel_ui,
                    )));
      } else {
        // setState(() {
        //   com = false;
        // });
        print("wrong");
      }
    } else {
      setState(() {
        // com = false;
        print("wrong");
      });
      print("wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Text(""),
          title: Text("                Price Tabel",
              style: TextStyle(fontSize: 15)),
          backgroundColor: Color(0xFF8d0101)),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  x = 7000;
                  y = "7000";
                  package = "Platinum";
                });
                openCheckout();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("Platinum",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("7000₹ / month",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                  ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  x = 5000;
                  y = "5000";
                  package = "Gold";
                });
                openCheckout();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFD7BE69),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("Gold",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("5000₹ / month",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                  ])),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  x = 3000;
                  y = "7000";
                  package = "Silver";
                });
                openCheckout();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFFBEC2CB),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ]),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("Silver",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 38.0),
                      child: Center(
                          child: Text("3000₹ / month",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))),
                    ),
                  ])),
            ),
          )
        ],
      )),
    );
  }
}
