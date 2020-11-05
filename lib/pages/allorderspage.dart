import 'dart:convert';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:loginui/constant.dart';
import 'package:loginui/models/pendingordermodal.dart';
import 'package:loginui/pages/orderdetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class OrederPage extends StatefulWidget {
  @override
  _OrederPageState createState() => _OrederPageState();
}

class _OrederPageState extends State<OrederPage> {
  Map transactions;
  List allitem;
  bool isloading = false;
  var hotelid;

  Future fetchdata() async {
    var map = Map<String, dynamic>();
    map["hotel_uid"] = hotelid;

    http.Response response = await http
        .post("https://treato.co.in/api/vendor/all_orders/", body: map);
    transactions = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);

      setState(() {
        allitem = transactions["all_orders"];
        print(allitem);
      });
    } else {
      print("345");
    }
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
    super.initState();
    print(hotelid);

    gethoteluid();

    //fetchdata();
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: AppBar(
          title: Text("All Order's", style: TextStyle(color: Colors.white)),
          backgroundColor: back,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Orderdetails()));
            //   },
            //   child: Align(
            //       alignment: Alignment.centerRight,
            //       child: Text("Details",
            //           style: TextStyle(
            //               fontSize: 20,
            //               color: Colors.green,
            //               decoration: TextDecoration.underline))),
            // ),
            allitem == null
                ? Center(
                    child: Column(children: [
                    SizedBox(
                      height: 300,
                    ),
                    Text("You dont't  Recive any Order's ")
                  ]))
                : ListView.builder(
                    reverse: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    itemCount: allitem == null ? 0 : allitem.length,
                    itemBuilder: (context, index) {
                      return Padding(
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
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      allitem[index]["username"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  )
                                ]),
                                SizedBox(
                                  height: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(children: [
                                    Text("Total Amount:  ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    Text(
                                      allitem[index]["total_amount"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(children: [
                                    Text("Delivery Boy:  ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    Text(
                                      allitem[index]["deliveryboy_name"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  ]),
                                ),
                                SizedBox(height: 7),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(children: [
                                    Text("Date:  ",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                    Text(
                                      allitem[index]["date"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    SizedBox(width: 5),
                                    Text(",  Time:  ",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    Text(
                                      allitem[index]["time"],
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )
                                  ]),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var transction =
                                        allitem[index]["transaction_uid"];
                                    print(transction);

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Orderdetails(
                                                  transid: transction,
                                                )));
                                  },
                                  child: Container(
                                      color: Colors.green,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("View Details"),
                                      )),
                                )
                              ],
                            )),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
