import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginui/Regestraion%20screen/paymentconfirmationpage.dart';
import 'package:loginui/Regestraion%20screen/step123screen.dart';
import 'package:loginui/constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

int x;

TextStyle textstyle = TextStyle(fontSize: 15, color: Colors.black);

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int hotel = 1999;
  int restaurants = 1999;
  int china_rest = 999;
  int snack_center = 999;
  int sweet_shops = 1999;
  int cake_shop = 1499;
  int cafe = 1999;
  int home_made = 999;
  int breakfast = 999;
  int small_tea = 1;
  int juice = 999;
  int icecream = 999;
  int bakery = 1499;
  int dairy = 999;
  int meat = 999;

  Razorpay razorpay;
  TextEditingController coinEditingController = new TextEditingController();

  String package;

  String trans_id;
  var paymentemail, paymentnumber;
  @override
  void initState() {
    getname();
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  getname() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      paymentemail = preferences.getString('paymentemail');
      paymentnumber = preferences.getString('paymentnumber');
    });
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_live_EUApQviWeUxdLm",
      // "key": "rzp_test_TjJecZ7MfB9igy",
      "amount": x * 100,
      "description": "Treato",
      "prefill": {"contact": paymentnumber, "email": paymentemail},
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
    if (x != null) {
      String apiUrl = "https://treato.co.in/api/vendor/registration_s6/";

      var map = Map<String, dynamic>();

      map["payment_amt"] = x.toString();
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
                builder: (context) =>
                    Paymentconfirm(package: package, ammount: x.toString())));
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
          backgroundColor: back),
      body: SingleChildScrollView(
          child: Column(
        children: [
          myrow("Hotels", hotel),
          myrow("Restaurants", restaurants),
          myrow("Chinese Restaurants", china_rest),
          myrow("Snack Center", snack_center),
          myrow("Sweet Shops", sweet_shops),
          myrow("Cake Shop", cake_shop),
          myrow("Cafe", cafe),
          myrow("Home Mader", home_made),
          myrow("BreakFast Stall", breakfast),
          myrow("Small Tea Stall", small_tea),
          myrow("Juice and Shakes", juice),
          myrow("icecream parlour", icecream),
          myrow("Bakery", bakery),
          myrow("Dairy Products", dairy),
          myrow("Meat Store", meat)
        ],
      )),
    );
  }

  Column myrow(String plan, int price) {
    return Column(children: [
      Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            plan,
            style: textstyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Price : ",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            price.toString(),
            style: textstyle,
          ),
        ),
      ]),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: RaisedButton(
            color: back,
            onPressed: () {
              setState(() {
                x = price;
                package = plan;
              });
              openCheckout();
            },
            child: Text("Pay Now")),
      )
    ]);
  }
}
