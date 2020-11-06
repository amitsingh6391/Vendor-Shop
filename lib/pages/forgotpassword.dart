import 'dart:convert';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:loginui/constant.dart';
import 'package:loginui/pages/newpassword.dart';

class Forgotpassword extends StatefulWidget {
  @override
  _ForgotpasswordState createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  bool com = false;

  final forgotkey = GlobalKey<FormState>();

  var otp;

  TextEditingController mobilenumber = TextEditingController();

  numbernotregisterd(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Mobile Number not register "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  otpget(BuildContext context) async {
    if (forgotkey.currentState.validate()) {
      String apiUrl = "https://treato.co.in/api/vendor/forgot_password/";

      var map = Map<String, dynamic>();

      map["text_mobile"] = mobilenumber.text.toString();

      print(mobilenumber.text);

      final response = await http.post(
        apiUrl,
        body: map,
      );
      Map data;
      data = json.decode(response.body);

      var x = data["result"];
      print(x);

      // setState(() {
      //   otp = data["otp"];
      // });

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200 && x != "Fail") {
        print(response.body);

        data = json.decode(response.body);

        setState(() {
          otp = data["otp"];
          com = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Newotpmatch(otp: otp, mobilenumber: mobilenumber.text)));
      } else {
        setState(() {
          com = false;
        });

        numbernotregisterd(context);
        print("wrong");
      }
    } else {
      setState(() {
        com = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: back,
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Container(
                //alignment: Alignment.bottomdown,

                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  backgroundImage: AssetImage("images/appicon.png"),
                ),
              ),
            ),
            Form(
                key: forgotkey,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    //  width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //    color: Color(0xFFFF0000),
                      borderRadius: BorderRadius.circular(29),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        return val.length == 10
                            ? null
                            : "Please Enter 10 digit vendor number";
                      },
                      controller: mobilenumber,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mobile_friendly),
                          hintText: "Vendor Mobile no.",
                          border: InputBorder.none),
                    ),
                  ),
                )),
            com ? CircularProgressIndicator() : Text(""),
            GestureDetector(
              onTap: () {
                setState(() {
                  com = true;
                });
                otpget(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: back,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}

class Newotpmatch extends StatefulWidget {
  var otp, mobilenumber;
  Newotpmatch({@required this.otp, @required this.mobilenumber});
  @override
  _NewotpmatchState createState() => _NewotpmatchState();
}

class _NewotpmatchState extends State<Newotpmatch> {
  TextEditingController otpnumber = TextEditingController();

  showAlertDialog(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Try Again"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Forgotpassword()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: back,
        ),
        body: SafeArea(
          child: Center(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Container(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  backgroundImage: AssetImage("images/appicon.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                //  width: size.width * 0.8,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  //    color: Color(0xFFFF0000),
                  borderRadius: BorderRadius.circular(29),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    return val.length == 4 ? null : "Enter OTP";
                  },
                  controller: otpnumber,
                  decoration: InputDecoration(
                      hintText: "Enter OTP.", border: InputBorder.none),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.otp = widget.otp.toString();
                  otpnumber.text = otpnumber.text.toString();
                });

                if (widget.otp == otpnumber.text) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              NewPassword(mobile: widget.mobilenumber)));
                } else {
                  showAlertDialog(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: back,
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ])),
        ));
  }
}
