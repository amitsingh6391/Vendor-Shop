import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
import 'package:loginui/Regestraion%20screen/addressscreen.dart';
import 'package:loginui/Regestraion%20screen/payment.dart';
import 'package:loginui/Regestraion%20screen/step123screen.dart';
import 'package:loginui/constant.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:geolocator/geolocator.dart';

class OtpVerification extends StatefulWidget {
  String vendor_mobile,
      vendor_password,
      vendor_email,
      vendor_name,
      hotel_name,
      hotel_mobile,
      hotel_phone,
      hotel_email;
  var otp;

  OtpVerification(
      {@required this.vendor_mobile,
      @required this.vendor_password,
      @required this.vendor_email,
      @required this.vendor_name,
      @required this.hotel_name,
      @required this.hotel_mobile,
      @required this.hotel_phone,
      @required this.hotel_email,
      @required this.otp});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController otpcontroller = TextEditingController();

  Position _currentPosition;
  String _currentAddress;

  final Geolocator geolocator = Geolocator();

  var lat, long;
  @override
  void initState() {
    super.initState();
    location();
  }

  location() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.latitude);
    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  otpmatch(BuildContext context) async {
    if (otpcontroller.text != null) {
      String apiUrl = "https://treato.co.in/api/vendor/otp_verify/";

      print(lat.toString());
      print(long.toString());
      print(otpcontroller.text);
      print(widget.hotel_name);
      print(widget.vendor_name);
      print(widget.vendor_email);
      print(widget.vendor_password);
      print(widget.vendor_mobile);
      print(widget.hotel_mobile);
      print(widget.hotel_phone);
      print(widget.hotel_email);

      var map = Map<String, dynamic>();
      map["vendor_name"] = widget.vendor_name;
      map["vendor_mobile"] = widget.vendor_mobile;
      map["vendor_password"] = widget.vendor_password;
      map["vendor_email"] = widget.vendor_email;
      map["hotel_name"] = widget.hotel_name;
      map["hotel_mobile"] = widget.hotel_mobile;
      map["hotel_phone"] = widget.hotel_phone;
      map["hotel_email"] = widget.hotel_email;
      // map["otp"] = otpcontroller.text;
      map["latitude"] = lat.toString();

      map["longitude"] = long.toString();

      print("yaaa");

      final response = await http.post(apiUrl, body: map);

      Map data;
      data = json.decode(response.body);
      String x = data["result"];
      print(data["result"]);

      if (response.statusCode == 200 && x == "Success") {
        String hotel_ui = data["hotel_uid"];
        print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Address(
                      hotel_id: hotel_ui,
                    )));
      } else {
        setState(() {
          com = false;
        });
        print("wrong");
      }
    } else {
      setState(() {
        com = false;
      });
    }
  }

  resendotp(BuildContext context) async {
    String apiUrl = "https://treato.co.in/api/vendor/otp_resend/";
    var map = Map<String, dynamic>();
    map["vendor_mobile"] = widget.vendor_mobile.toString();
    map["otp"] = widget.otp.toString();
    final response = await http.post(apiUrl, body: map);
    if (response.statusCode == 200) {
      print(response.body);
      print("ok");
    } else {
      showAlertDialog(context);
    }
  }

  bool com = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: back),
      body: SingleChildScrollView(
          child: Container(
              // height: size.height * 1,
              width: size.width * 1,
              child: Center(
                  child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                      height: size.height * .23,
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/appicon.png"),
                            radius: 80,
                          ),
                        ),
                      ])),
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  "Enter OTP",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 30, right: 30),
                  child: Center(
                    child: Text(
                      "We have sent otp via sms for mobile number verfication",
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: size.width * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: otpcontroller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "OTP",
                        // border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                com
                    ? Column(children: [
                        Text("Wait a second"),
                        CircularProgressIndicator()
                      ])
                    : Text(""),
                GestureDetector(
                  onTap: () {
                    print(widget.otp);

                    print(otpcontroller.text.toString());

                    if (otpcontroller.text.length == 4) {
                      print("hlo");
                      setState(() {
                        com = true;
                      });

                      print(otpcontroller.text);
                      if (widget.otp == int.parse(otpcontroller.text)) {
                        setState(() {
                          com = true;
                        });
                        otpmatch(context);
                      } else {
                        setState(() {
                          com = false;
                        });
                        showAlertDialog(context);
                      }
                    } else {
                      showempty(context);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: back,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Didn't not Receive the OTP "),
                ),
                GestureDetector(
                  onTap: () {
                    resendotp(context);
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ])))),
    );
  }

  showempty(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        resendotp(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("please inter OTP"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showAlertDialog(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Resend OTP"),
      onPressed: () {
        resendotp(context);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Wrong OTP "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
