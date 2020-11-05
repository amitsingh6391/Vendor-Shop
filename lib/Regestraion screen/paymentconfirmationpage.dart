import "package:flutter/material.dart";
import 'package:loginui/constant.dart';
import 'package:loginui/main.dart';

class Paymentconfirm extends StatelessWidget {
  String package, ammount;
  Paymentconfirm({this.package, this.ammount});

  showAlertDialog(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Login now"),
      onPressed: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Homepage()));

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Homepage(
                    // hotel_id: widget.hotel_uid
                    )));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Success "),
      content: Text(
          "Your Account is successfully created . Please enter your vendor number & password to login in app "),
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
            title: Text("Payment confirmation Page"),
            backgroundColor: back),
        body: Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("images/appicon.png"),
              )),
            ),
            Text(
              "Your Payment is Successfully done",
              style: TextStyle(fontSize: 20, color: back),
            ),
            Icon(Icons.check, size: 40, color: back),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                "Your KYC is under Process,Your account will be activated in 24 hr.",
                style: TextStyle(fontSize: 15, color: back),
              ),
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: CircleAvatar(
                    backgroundColor: back,
                    radius: 25,
                    child: Icon(Icons.arrow_forward),
                  )),
            )
          ],
        )));
  }
}
