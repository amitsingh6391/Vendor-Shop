import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:loginui/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loginui/Regestraion%20screen/otp_verification.dart';
import 'package:loginui/Regestraion%20screen/step4.dart';

class Updateprofile extends StatefulWidget {
  @override
  _UpdateprofileState createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  TextEditingController hotelname = new TextEditingController();
  TextEditingController vendorname = new TextEditingController();
  TextEditingController vendormobilenumber = new TextEditingController();
  TextEditingController vendoremail = new TextEditingController();
  TextEditingController vendorpassword = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  TextEditingController hotelmobilenumber = new TextEditingController();
  TextEditingController hotelemail = new TextEditingController();
  TextEditingController hotelphonenumber = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  var vendorid,hotelid;
 @override
 void initState(){

   super.initState();
   getid();

  }

getid() async{
SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                           setState((){
                                              hotelid = preferences.getString(
                                                'hotel_uid');
                                               vendorid =  preferences.getString(
                                                'vendor_uid');
                                           });


                                           print("*********$hotelid");
                                           print("************$vendorid");
}


  update(BuildContext context) async {
    if (formKey.currentState.validate()) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('paymentemail', vendoremail.text);
      preferences.setString('paymentnumber', vendormobilenumber.text);
      final String apiurl = "https://treato.co.in/api/vendor/update_profile/";
      var map = Map<String, dynamic>();

      map["vendor_mobile"] = vendormobilenumber.text;
      map["vendor_email"] = vendorpassword.text;
      map["vendor_name"] = vendorname.text;
      map["hotel_name"] = hotelname.text;
      map["hotel_mobile"] = hotelmobilenumber.text;
      map["hotel_email"] = hotelemail.text;
      map["hotel_uid"] = hotelid;
      map["vendor_uid"] = vendorid;


      final response = await http.post(apiurl, body: map);
      Map data;

      print(response.statusCode);

      data = json.decode(response.body);
      print(data);
      // String x = data["result"];
      // var y = data["otp"];
      // String z = data["status"];

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          com = false;
        });
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => OtpVerification(
        //             vendor_email: vendoremail.text,
        //             vendor_mobile: vendormobilenumber.text,
        //             vendor_name: vendorname.text,
        //             hotel_name: hotelname.text,
        //             hotel_email: hotelemail.text,
        //             hotel_phone: hotelphonenumber.text,
        //             hotel_mobile: hotelmobilenumber.text,
        //             vendor_password: vendorpassword.text,
        //             otp: y)));
      } else {
        print(response.statusCode);
        setState(() {
          com = false;
        });
       // showAlertDialog(context, z);
      }
    } else {
      setState(() {
        com = false;
      });
    }
  }

  showAlertDialog(BuildContext context, String z) {
    Widget okbtn = FlatButton(
      child: Text("retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text(z),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  bool com = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
  
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: back,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 1,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(children: [
                  
                  ])),
              SingleChildScrollView(
                child: Container(
                  //height: size.height * 0.69,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                       
                        Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
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
                                  ]),
                              child: TextFormField(
                                validator: (val) {
                                  return val.length > 3
                                      ? null
                                      : "Enter Hotel name 3+ char";
                                },
                                controller: hotelname,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: "Hotel name",
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
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                validator: (val) {
                                  return val.length > 3
                                      ? null
                                      : "Enter vendor name 3+ char";
                                },
                                controller: vendorname,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: "Vendor name",
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
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (val) {
                                  return val.length == 10
                                      ? null
                                      : "Enter valid vendor mobile number";
                                },
                                controller: vendormobilenumber,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.phone_android),
                                    hintText: "vendor mobile no.",
                                    border: InputBorder.none),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please Enter Correct Email";
                                },
                                controller: vendoremail,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.mail),
                                    hintText: " vendor Email",
                                    border: InputBorder.none),
                              ),
                            ),
                          ],
                        ),
                       
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          width: size.width * 0.8,
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
                                  : "Enter Hotel Mobile number";
                            },
                            controller: hotelmobilenumber,
                            decoration: InputDecoration(
                                icon: Icon(Icons.school),
                                hintText: "Hotel Mobile no.",
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
                            // color: kPrimaryLightColor,
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
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              return RegExp(
                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(val)
                                  ? null
                                  : "Please Enter Correct Hotel Email";
                            },
                            controller: hotelemail,
                            decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: "Hotel Email",
                                border: InputBorder.none),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 5),
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 10,
                        //   ),
                        //   width: size.width * 0.8,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(29),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           color: Colors.grey.withOpacity(0.5),
                        //           spreadRadius: 5,
                        //           blurRadius: 7,
                        //           offset: Offset(0, 3))
                        //     ],
                        //   ),
                        //   child: TextFormField(
                        //     keyboardType: TextInputType.number,
                        //     validator: (val) {
                        //       return val.length == 10 || val.length == 11
                        //           ? null
                        //           : "Enter Correct hotel Phone number";
                        //     },
                        //     controller: hotelphonenumber,
                        //     decoration: InputDecoration(
                        //         icon: Icon(Icons.phone_android),
                        //         hintText: "Hotel phone no.",
                        //         border: InputBorder.none),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              com ? CircularProgressIndicator() : Text(""),
              GestureDetector(
                onTap: () {
                  setState(() {
                    com = true;
                  });
                  update(context);
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
            ],
          ),
        ),
      ),
    );
  }
}