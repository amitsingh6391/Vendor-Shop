import "package:flutter/material.dart";
import 'package:loginui/Regestraion%20screen/step123screen.dart';
import 'package:loginui/constant.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:loginui/main.dart';

class Address extends StatefulWidget {
  String hotel_id;
  Address({@required this.hotel_id});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String x;
  List<String> state = [
    "Andhra Pradesh",
    "Assam",
    "Arunachal Pradesh",
    "Bihar",
    "Goa",
    "Gujarat",
    "Jammu and Kashmir",
    "Jharkhand,"
        "West Bengal",
    "Karnatak",
    "Kerala,",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Orissa",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Tripura",
    "Uttaranchal",
    "Uttar Pradesh",
    "Haryana",
    "Himachal Pradesh",
    "Chhattisgarh"
  ];

  bool com = false;

  final addresskey = GlobalKey<FormState>();

  addressmatch(BuildContext context) async {
    if (addresskey.currentState.validate() && x != null) {
      String apiUrl = "https://treato.co.in/api/vendor/registration_s6/";

      var map = Map<String, dynamic>();
      map["text_city"] = city.text;
      map["text_pincode"] = pincode.text;
      map["text_address"] = address.text;
      map["text_state"] = x;
      map["hotel_uid"] = widget.hotel_id;
      print("yaaa");

      final response = await http.post(apiUrl, body: map);

      Map data;
      data = json.decode(response.body);
      print(response.body);
      String y = data["result"];
      print(data["result"]);

      if (response.statusCode == 200 && y == "Success") {
        print(response.body);
        setState(() {
          com = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Step2(
                      hotel_uid: widget.hotel_id,
                    )));
      } else {
        setState(() {
          com = false;
        });
        showempty(context);
        print("wrong");
      }
    } else {
      setState(() {
        com = false;
      });
       showempty(context);
    }
  }

  showempty(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Try - again"),
      onPressed: () {
        Navigator.pop(
            context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Please Fill Each Field"),
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
          backgroundColor: back,
        ),
        body: Container(
          child: Form(
            key: addresskey,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DropdownButton(
                  hint: Text(
                      'Please choose Your State'), // Not necessary for Option 1
                  value: x,
                  onChanged: (newValue) {
                    setState(() {
                      x = newValue;
                    });
                  },
                  items: state.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  validator: (val) {
                    return val.length > 2 ? null : "Enter Valid city name";
                  },
                  controller: city,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city),
                      hintText: "City",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    return val.length == 6 ? null : "Enter Valid pin number";
                  },
                  controller: pincode,
                  
                  decoration: InputDecoration(
                      icon: Icon(Icons.pin_drop),
                      hintText: "Pincode",
                      border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  validator: (val) {
                    return val.length > 4 ? null : "Enter Valid Address";
                  },
                  controller: address,
                  maxLines:3,
                  decoration: InputDecoration(
                      icon: Icon(Icons.home),
                      hintText: "Address",
                      border: InputBorder.none),
                ),
              ),
              com ? CircularProgressIndicator() : Text(""),
              GestureDetector(
                onTap: () {
                  setState(() {
                    com = true;
                  });
                  addressmatch(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: back,
                          child: Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
