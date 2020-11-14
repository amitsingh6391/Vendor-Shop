import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:loginui/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loginui/Regestraion%20screen/otp_verification.dart';
import 'package:loginui/Regestraion%20screen/step4.dart';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController newpassword = new TextEditingController();
 
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


                                          
                                           print("************$vendorid");
}


  update(BuildContext context) async {

     
      final String apiurl = "https://treato.co.in/api/vendor/change_password/";
      var map = Map<String, dynamic>();

      map["vendor_password"] = newpassword.text;
      map["vendor_uid"] = vendorid;


      final response = await http.post(apiurl, body: map);
      Map data;


print("Response ");
      print(response.statusCode);

     // data = json.decode(response.body);
     // print(data);
      

      if (response.statusCode == 200) {
        //print(response.body);
        setState(() {
          com = false;
        });
      
      } if(response.statusCode !=200){
        print(response.statusCode);
        setState(() {
          com = false;
        });
       showAlertDialog(context);
      }
    
  }

  showAlertDialog(BuildContext context) {
    Widget okbtn = FlatButton(
      child: Text("retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Something Wrong please try some time after"),
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
        title: Text("Update Password"),
        backgroundColor: back,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 1,
          child: Column(
            children: [
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
              Padding(
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
                     // keyboardType: TextInputType.number,
                      validator: (val) {
                        return val.length>6
                            ? null
                            : "New Password";
                      },
                      controller:newpassword,
                      decoration: InputDecoration(
                          icon: Icon(Icons.remove_red_eye),
                          hintText: "New Password.",
                          border: InputBorder.none),
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