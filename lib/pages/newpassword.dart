import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:loginui/constant.dart';

import 'dart:convert';

import 'package:loginui/main.dart';

class NewPassword extends StatefulWidget {
  var mobile;
  NewPassword({@required this.mobile});
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController password = TextEditingController();

  bool com = false;
  passwordreset(BuildContext context) async {
    if (password.text != null) {
      String apiUrl = "https://treato.co.in/api/vendor/new_password/";

      var map = Map<String, dynamic>();

      map["text_mobile"] = widget.mobile;
      map["text_password"] = password.text;

      final response = await http.post(apiUrl, body: map);

      Map data;
      data = json.decode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          com = false;
        });
        print(response.body);
        showlogin(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => Step2(
        //               hotel_uid: hotel_ui,
        //             )));
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
      showAlertDialog(context);
    }
  }

  showlogin(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Login-now"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
        ;
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Success"),
      content: Text("Your Password is Successfully updated login again"),
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
      child: Text("Try Again"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Your Password is Very Weak"),
      content: Text(
          "Your Password consist one special symbol,1 number and at least 5 digits"),
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
        appBar: AppBar(backgroundColor: back,
          leading: Text(""),
          actions: [],
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Container(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("images/appicon.png"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: MediaQuery.of(context).size.width * 0.6,
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
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      hintText: "      Enter New Password ",
                      border: InputBorder.none),
                ),
              ),
            ),
            com
                ? Column(children: [
                    Text("Wait a second"),
                    CircularProgressIndicator()
                  ])
                : Text(""),
            GestureDetector(
              onTap: () {
                if (password.text.length > 4) {
                  setState(() {
                    com = true;
                  });
                  passwordreset(context);
                } else {
                  showAlertDialog(context);
                }
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: back,
                child: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40, top: 18),
              child: Text("Notice : Your Password have at least 5 digit"),
            ),
          ]),
        ));
  }
}
