import 'dart:convert';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:loginui/models/pendingordermodal.dart';
import 'package:loginui/pages/orderdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class PendingPage extends StatefulWidget {
  // final String hotel_id;
  // PendingPage({@required this.hotel_id});
  @override
  _PendingPageState createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  Map transactions;
  List pendingitem;
  bool isloading = false;
  var hotelid;

  Future fetchdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "loggedin");

    var map = Map<String, dynamic>();
    print(hotelid);
    map["hotel_uid"] = hotelid;

    http.Response response = await http
        .post("https://treato.co.in/api/vendor/pending_order/", body: map);
    transactions = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("hii");

      setState(() {
        pendingitem = transactions["pending_orders"];
        print(pendingitem);
      });

      //print(pendingitem[0]["transaction_uid"]);
    } else {
      print("345");
    }

    SharedPreferences transid = await SharedPreferences.getInstance();
    preferences.setString('email', pendingitem[0]["transaction_uid"]);
  }

  gethoteluid() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    hotelid = preferences.getString('hotel_uid');
    setState(() {
      hotelid = preferences.getString('hotel_uid');
      print(hotelid);
      fetchdata();
    });
  }

  @override
  void initState() {
    print("amit");
    print(hotelid);
    gethoteluid();
    super.initState();
    //print(hotelid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () {
          return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("YES"),
                      onPressed: () {
                        exit(0);
                      },
                    ),
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "Pending Orders",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xFF8d0101),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: 20),
                pendingitem == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 300),
                        child: Center(
                            child: Text("You don't have any Pending orders")),
                      )
                    : ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shrinkWrap: true,
                        itemCount: pendingitem == null ? 0 : pendingitem.length,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFf2f2f2),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Text(
                                            pendingitem[index]["username"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                        )
                                      ]),
                                      SizedBox(height: 7),
                                      Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("Delivery Boy :  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ),
                                        Text(
                                          pendingitem[index]
                                              ["deliveryboy_name"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        )
                                      ]),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text("Total Amount:  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                        ),
                                        Text(
                                          pendingitem[index]["total_amount"],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        )
                                      ]),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Row(children: [
                                          Text("Date:  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                          Text(
                                            pendingitem[index]["date"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(width: 5),
                                          Text(",  Time:  ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black)),
                                          Text(
                                            pendingitem[index]["time"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15),
                                          )
                                        ]),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var transction = pendingitem[index]
                                              ["transaction_uid"];
                                          print(transction);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Pendigndetails(
                                                        transid: transction,
                                                      )));
                                        },
                                        child: Container(
                                            color: Colors.green,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("View Details"),
                                            )),
                                      )
                                    ],
                                  )),
                            )
                          ]);
                        },
                      ),
              ]),
            )));
  }
}
