import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:loginui/Regestraion%20screen/step7.dart';
import 'package:loginui/constant.dart';

GlobalKey catkey = GlobalKey();

var id;

class Step6 extends StatefulWidget {
  final String hotel_uid;
  Step6({@required this.hotel_uid});

  @override
  _Step6State createState() => _Step6State();
}

class _Step6State extends State<Step6> {
  TextEditingController category = TextEditingController();
  Map item;
  List all_item;
  allcategory() async {
    final String apiUrl = "https://treato.co.in/api/vendor/category_list/";

    var map = Map<String, dynamic>(); //in this step everuthing fine
    map["hotel_uid"] = widget.hotel_uid;

    print(map);

    final response = await http.post(apiUrl, body: map);

    item = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);

      print(response.body);

      setState(() {
        all_item = item["categories"];
        com = false;
        print("hiii");
        print(all_item);
      });
    } else {
      print("345");
    }
  }

  addcategory() async {
    final String apiUrl = "https://treato.co.in/api/vendor/category/";

    print(widget.hotel_uid);
    print(category.text);

    var map = Map<String, dynamic>();
    map["hotel_uid"] = widget.hotel_uid;

    map["category_name"] = category.text;

    final response = await http.post(apiUrl, body: map);
    if (response.statusCode == 200) {
      print("Everything ok");
      setState(() {
        allcategory();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    allcategory();
    super.initState();
  }

  bool com = false;

  showAlertDialog(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Try Again"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Please Enter valid Category name."),
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
      //backgroundColor: Color(0xff203152),
      appBar: AppBar(
          title: Text(
            "Registration",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: back),
      body: SingleChildScrollView(
        child: Container(
            width: size.width * 1,
            child: Column(children: [
              SizedBox(height: 20),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text("step 6  . . . . . .",
                      style: TextStyle(
                        fontSize: 20,
                        // fontWeight: FontWeight.bold
                      ))),
              //SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text("(ADD NEW CATEGORY)",
                    style: TextStyle(
                        fontSize: 20,
                        color: back,
                        fontWeight: FontWeight.bold)),
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: category,
                    decoration: InputDecoration(hintText: "category name"),
                  ),
                ),
              ),

              com ? CircularProgressIndicator() : Text(""),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RaisedButton(
                  color: back,
                  onPressed: () {
                    if (category.text.length > 1) {
                      print("null hi");
                      print(category.text);
                      setState(() {
                        com = true;
                      });
                      addcategory();
                    } else {
                      showAlertDialog(context);
                    }
                  },
                  child: Text("ADD", style: TextStyle(color: Colors.white)),
                ),
              ),

              SizedBox(height: 10),
              Row(children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "LIST OF ALL CATEGORY",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 100),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Step7(
                                  hotel_uid: widget.hotel_uid,
                                  id: id,
                                )));
                  },
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: back,
                        radius: 25,
                        child: Icon(Icons.arrow_forward),
                      )),
                ),
              ]),

              SizedBox(height: 20),
              all_item == null
                  ? Container(child: Text(""))
                  : Container(
                      child: Text(
                        "(select your category to add new item)",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
              ListView.builder(
                reverse: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: all_item == null ? 0 : all_item.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        id = all_item[index]["category_uid"];
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Step7(
                                    hotel_uid: widget.hotel_uid,
                                    id: id,
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: size.height * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Row(children: [
                                Text("CATEGORY Name:  ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      // color: Colors.black
                                    )),
                                Text(
                                  all_item[index]["category_name"],
                                  style: TextStyle(
                                      color: back,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 100),
              all_item == null
                  ? Container(
                      child: Text("(You don't have any category..)",
                          style: TextStyle(color: Colors.blue)))
                  : Container()
            ])),
      ),
    );
  }
}
