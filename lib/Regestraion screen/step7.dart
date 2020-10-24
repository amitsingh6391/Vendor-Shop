import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loginui/main.dart';
import 'package:loginui/pages/pendingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:search_widget/search_widget.dart';

class Step7 extends StatefulWidget {
  final String hotel_uid;
  var id;
  Step7({@required this.hotel_uid, @required this.id});
  @override
  _Step7State createState() => _Step7State();
}

class _Step7State extends State<Step7> {
  File itemimage;
  TextEditingController price = TextEditingController();
  TextEditingController item_name = TextEditingController();

  bool com = false;

  showAlert(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("Try Again"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Please Enter  Details of Your item."),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future<void> getitemimg() async {
    // correct this image picker
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropitemimg(image);
  }

  cropitemimg(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      itemimage = croppedImage;
    });
  }

  Map item;
  List all_item;
  dynamic _dropDownValue;
  getitemdata() async {
    final String apiUrl = "https://treato.co.in/api/vendor/item_list/";

    var map = Map<String, dynamic>(); //in this step everuthing fine
    map["hotel_uid"] = widget.hotel_uid;

    print(map);

    final response = await http.post(apiUrl, body: map);

    item = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);

      print(response.body);

      setState(() {
        all_item = item["items"];
        print("hiii");
        com = false;
        print(all_item);
      });
    } else {
      setState(() {
        com = false;
      });
      print("345");
    }
  }

  additem() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString('hotel_uid', widget.hotel_uid);

    final String apiUrl =
        "https://treato.co.in/api/vendor/add_item/"; //can we call getitem in setstate..?
    // var map = Map<String, dynamic>();
    Map<String, String> map = {
      "hotel_uid": widget.hotel_uid.toString(),
      "category_uid": widget.id.toString(),
      "price": price.text.toString(),
      "item_name": item_name.text.toString(),
      // "item_image": itemimage   //why we comment this is it not neccsessary
    };

    print(map);
    var uri = Uri.parse(apiUrl);
    // final response = await http.post(apiUrl, body: map);
    final request = http.MultipartRequest('POST', uri)
      ..fields.addAll(map)
      ..files.add(await http.MultipartFile.fromPath(
          'item_image',
          itemimage
              .path)); //this is where you add image filepath ok it mean we are

    var response = await request.send();
    print("request");
    print(request);

    final respStr =
        await response.stream.bytesToString(); //post image parametrs there
    print(respStr);

    setState(() {
      getitemdata();
    });
    return jsonDecode(respStr);
  }

//list of all category in dropdown...
  Map category;
  List all_category = ["Sweets"];
  bool x = false;
  String cat = " ";

  allcat() async {
    final String apiUrl = "https://treato.co.in/api/vendor/category_list/";

    var map = Map<String, dynamic>(); //in this step everuthing fine
    map["hotel_uid"] = widget.hotel_uid;

    print(map);

    final response = await http.post(apiUrl, body: map);

    category = json.decode(response.body);

    if (response.statusCode == 200) {
      print(response.statusCode);

      print(response.body);

      setState(() {
        all_category = category["categories"];
        print("hiii");
        print(all_category);
      });
    } else {
      print("345");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.hotel_uid);

    allcat();

    print(widget.id);
    print(all_item);
    super.initState();
    getitemdata();
  }

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Color(0xff203152),
        appBar: AppBar(
            title: Text("Registration"), backgroundColor: Color(0xFF8d0101)),
        body: SingleChildScrollView(
          child: Container(
              width: size.width * 1,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("step 7  . . . . . . .",
                          style: TextStyle(
                            fontSize: 20,
                            // fontWeight: FontWeight.bold
                          ))),
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "ADD ITEM",
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xFF8d0101)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            getitemimg();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                              ),
                              child: itemimage == null
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                          child: Column(
                                        children: [
                                          SizedBox(height: size.height * 0.07),
                                          Text("upload item image"),
                                          SizedBox(height: 20),
                                          Icon(Icons.add_a_photo)
                                        ],
                                      )),
                                    )
                                  : Image.file(
                                      itemimage,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ],
                            ),
                            child: Row(children: [
                              Expanded(
                                child: TextField(
                                  controller: item_name,
                                  decoration:
                                      InputDecoration(hintText: "  Item name"),
                                ),
                              ),
                              Text("  |   ",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold)),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: price,
                                  decoration:
                                      InputDecoration(hintText: "Price"),
                                ),
                              )
                            ]),
                          ),
                        ),
                        Row(children: [
                          Text(
                            "Change Your category",
                            style: TextStyle(color: Color(0xFF8d0101)),
                          ),
                          SizedBox(width: 40),
                          GestureDetector(
                            child: Icon(Icons.arrow_drop_down,
                                size: 50, color: Color(0xFF8d0101)),
                            onTap: () {
                              print("okk");
                              setState(() {
                                x = true;
                              });
                            },
                            onDoubleTap: () {
                              setState(() {
                                x = false;
                              });
                            },
                          )
                        ]),
                        x == false
                            ? Container(
                                child: Text(cat,
                                    style: TextStyle(color: Color(0xFF8d0101))))
                            // : Container(
                            //     child: Text(
                            //       "(select your category to add new item)",
                            //       style: TextStyle(color: Colors.blue),
                            //     ),
                            //   ),
                            : ListView.builder(
                                reverse: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                shrinkWrap: true,
                                itemCount: all_category == null
                                    ? 0
                                    : all_category.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.id =
                                            all_category[index]["category_uid"];
                                        print("chnage cate id");
                                        print(widget.id);
                                        cat = all_category[index]
                                            ["category_name"];
                                        x = false;
                                      });
                                      print(widget.id);
                                    },
                                    child: Container(
                                      // height: size.height * .3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            //height: size.height * 0.3,
                                            child: Card(
                                          elevation: 10,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(children: [
                                                Text("CATEGORY Name:  ",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      // color: Colors.black
                                                    )),
                                                Text(
                                                  all_category[index]
                                                      ["category_name"],
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ]),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                              child: RaisedButton(
                            child: Text("ADD"),
                            color: Color(0xFFFCCDCD),
                            onPressed: () {
                              if (price.text.length > 0 &&
                                  item_name.text.length > 1) {
                                setState(() {
                                  com = true;
                                  additem();
                                  getitemdata();
                                });
                              } else {
                                showAlert(context);
                              }
                            },
                          )),
                        ),
                        SizedBox(height: 10),
                        com ? CircularProgressIndicator() : Text(""),
                        GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 50,
                              width: 100,
                              color: Color(0xFF8d0101),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " Finish ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LIST OF ITEMS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ListView.builder(
                          reverse: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shrinkWrap: true,
                          itemCount: all_item == null ? 0 : all_item.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    // height: size.height * 0.3,
                                    child: Card(
                                  elevation: 10,
                                  child: Column(
                                    children: [
                                      Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 70,
                                            backgroundImage: NetworkImage(
                                                all_item[index]["item_img"]),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(children: [
                                          Text(
                                            "Item name:  ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                all_item[index]["item_name"]),
                                          ),
                                          Text(
                                            "Item Category:  ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(all_item[index]
                                                ["item_category"]),
                                          )
                                        ])
                                      ])
                                    ],
                                  ),
                                )),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 100),
                        all_item == null
                            ? Container(
                                child: Text("(You don't have any item yet..)",
                                    style: TextStyle(color: Colors.blue)))
                            : Container()
                      ],
                    ),
                  )
                ],
              )),
        ));
  }
}
