import 'dart:convert';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:loginui/models/allordermodal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orderdetails extends StatefulWidget {
  final String transid;

  Orderdetails({@required this.transid});
  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  Map order;
  List alloredr;

  var vendorid;
  String x = " ";

  vendor() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorid = preferences.getString('vendor_uid');
    setState(() {
      vendorid = preferences.getString('vendor_uid');
      print(vendorid);
    });
  }

  orderdetails() async {
    final String apiUrl = "https://treato.co.in/api/vendor/order_details/";

    var map = Map<String, dynamic>();
    map["transaction_uid"] = widget.transid;
    final response = await http.post(apiUrl, body: map);
    order = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        alloredr = order["order_details"];
        print("order");
        print(alloredr);
      });
    } else {
      print("345");
    }
  }

  //alertbox...

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(x),
      content: Text("You have submit your order status Successfully. "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  ///step 7 problem occurs

  orderstatus() async {
    final String apiUrl = "https://treato.co.in/api/vendor/order_confirmation/";

    var map = Map<String, dynamic>();
    map["transaction_uid"] = widget.transid;
    map["vendor_uid"] = vendorid;
    map["order_confirmation"] = x;
    print(vendorid);
    final response = await http.post(apiUrl, body: map);
    order = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        com = false;
        print("order");
      });

      showAlertDialog();
    } else {
      print("345");
    }
  }

  @override
  void initState() {
    print("ghhhj");
    vendor();

    orderdetails();
    super.initState();
  }

  bool com = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(" All Order Details"),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                height: size.height * .5,
                width: size.width * 1,
                child: Column(
                  children: [
                    Card(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 8),
                              child: Text("Order",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ))),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Item Name",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, bottom: 8, right: 8),
                            child: Text("Price",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Text("X"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Quantity",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8, bottom: 8),
                            child: Text("Total",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )),
                    ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: alloredr == null ? 0 : alloredr.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // color: Colors.yellow,
                          child: Row(
                            children: [
                              Container(
                                //color: Colors.red,
                                width: size.width * 0.27,
                                child: Text(
                                  alloredr[index]["item_name"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 6),
                              Container(
                                //    color: Colors.blue,
                                width: size.width * 0.13,
                                child: Text(
                                  alloredr[index]["amount"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              Text(" X   "),
                              SizedBox(width: size.width * 0.05),
                              Container(
                                width: size.width * 0.09,
                                //color: Colors.yellow,
                                child: Text(
                                  alloredr[index]["qty"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: size.width * 0.06),
                              Container(
                                width: size.width * 0.2,
                                //color: Colors.pink,
                                child: Text(
                                  alloredr[index]["total_amount"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        );
                      },
                    ),
                    com ? CircularProgressIndicator() : Text(""),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          FlatButton(
                            color: Colors.green,
                            child: Text("ACCEPT",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              print("accept");
                              setState(() {
                                com = true;
                                x = "Accepted";
                              });
                              orderstatus();
                            },
                          ),
                          SizedBox(width: 10),
                          FlatButton(
                            color: Colors.yellow,
                            child: Text("Pending",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              print("oenif");
                              setState(() {
                                com = true;
                                x = "On The Way";
                              });
                              orderstatus();
                            },
                          ),
                          SizedBox(width: 10),
                          FlatButton(
                            color: Colors.red,
                            child: Text("REJECT",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              setState(() {
                                com = true;
                                x = "Rejected";
                              });
                              orderstatus();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

//pending oreder details...

class Pendigndetails extends StatefulWidget {
  final String transid;

  Pendigndetails({@required this.transid});
  @override
  _PendigndetailsState createState() => _PendigndetailsState();
}

class _PendigndetailsState extends State<Pendigndetails> {
  Map order;
  List alloredr;

  var vendorid;
  String x = " ";

  bool com = false;

  vendor() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    vendorid = preferences.getString('vendor_uid');
    setState(() {
      vendorid = preferences.getString('vendor_uid');
      print(vendorid);
    });
  }

  //alertbox...

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(x),
      content: Text("You have submit your order status Successfully. "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  ///step 7 problem occurs

  orderstatus() async {
    final String apiUrl = "https://treato.co.in/api/vendor/order_confirmation/";

    var map = Map<String, dynamic>();
    map["transaction_uid"] = widget.transid;
    map["vendor_uid"] = vendorid;
    map["order_confirmation"] = x;
    print(vendorid);
    final response = await http.post(apiUrl, body: map);
    order = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        com = false;
        print("order");
      });

      showAlertDialog();
    } else {
      print("345");
    }
  }

  @override
  void initState() {
    print("ghhhj");
    vendor();

    orderdetails();
    super.initState();
  }

  orderdetails() async {
    final String apiUrl = "https://treato.co.in/api/vendor/order_details/";

    var map = Map<String, dynamic>();
    map["transaction_uid"] = widget.transid;
    final response = await http.post(apiUrl, body: map);
    order = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        alloredr = order["order_details"];
        print("order");
        print(alloredr);
      });
    } else {
      print("345");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Order Details"),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                height: size.height * .5,
                width: size.width * 1,
                child: Column(
                  children: [
                    Card(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8, top: 8),
                              child: Text("Order",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ))),
                    Card(
                        child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Item Name",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, bottom: 8, right: 8),
                            child: Text("Price",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Text("X"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Quantity",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8, bottom: 8),
                            child: Text("Total",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    )),
                    ListView.builder(
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      shrinkWrap: true,
                      itemCount: alloredr == null ? 0 : alloredr.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // color: Colors.yellow,
                          child: Row(
                            children: [
                              Container(
                                //color: Colors.red,
                                width: size.width * 0.27,
                                child: Text(
                                  alloredr[index]["item_name"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 6),
                              Container(
                                //    color: Colors.blue,
                                width: size.width * 0.13,
                                child: Text(
                                  alloredr[index]["amount"].toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              Text(" X   "),
                              SizedBox(width: size.width * 0.05),
                              Container(
                                width: size.width * 0.09,
                                //color: Colors.yellow,
                                child: Text(
                                  alloredr[index]["qty"],
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: size.width * 0.06),
                              Container(
                                width: size.width * 0.2,
                                //color: Colors.pink,
                                child: Text(
                                  alloredr[index]["total_amount"],
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              SizedBox(height: 30),
                            ],
                          ),
                        );
                      },
                    ),
                    com ? CircularProgressIndicator() : Text(""),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          SizedBox(width: size.width * 0.18),
                          FlatButton(
                            color: Colors.green,
                            child: Text("ACCEPT",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              setState(() {
                                com = true;
                                x = "Accepted";
                              });
                              orderstatus();
                            },
                          ),
                          SizedBox(width: 10),
                          FlatButton(
                            color: Colors.red,
                            child: Text("REJECT",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () {
                              setState(() {
                                com = true;
                                x = "Rejected";
                              });
                              orderstatus();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
