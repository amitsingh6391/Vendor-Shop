import 'dart:convert';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import "package:http/http.dart" as http;
import 'package:loginui/Regestraion%20screen/otp_verification.dart';
import 'package:loginui/Regestraion%20screen/step4.dart';

final formKey = GlobalKey<FormState>();
final step2key = GlobalKey<FormState>();

class Step1 extends StatefulWidget {
  @override
  _Step1State createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  TextEditingController hotelname = new TextEditingController();
  TextEditingController vendorname = new TextEditingController();
  TextEditingController vendormobilenumber = new TextEditingController();
  TextEditingController vendoremail = new TextEditingController();
  TextEditingController vendorpassword = new TextEditingController();
  TextEditingController confirmpassword = new TextEditingController();
  TextEditingController hotelmobilenumber = new TextEditingController();
  TextEditingController hotelemail = new TextEditingController();
  TextEditingController hotelphonenumber = new TextEditingController();

  singUp(BuildContext context) async {
    if (formKey.currentState.validate()) {
      final String apiurl = "https://treato.co.in/api/vendor/registration_s1/";
      var map = Map<String, dynamic>();

      map["vendor_mobile"] = vendormobilenumber.text;
      map["vendor_email"] = vendorpassword.text;

      final response = await http.post(apiurl, body: map);
      Map data;

      data = json.decode(response.body);
      String x = data["result"];
      var y = data["otp"];
      String z = data["status"];

      if (response.statusCode == 200 && x == "Success") {
        print(response.body);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpVerification(
                    vendor_email: vendoremail.text,
                    vendor_mobile: vendormobilenumber.text,
                    vendor_name: vendorname.text,
                    hotel_name: hotelname.text,
                    hotel_email: hotelemail.text,
                    hotel_phone: hotelphonenumber.text,
                    hotel_mobile: hotelmobilenumber.text,
                    vendor_password: vendorpassword.text,
                    otp: y)));
      } else {
        print(response.statusCode);
        setState(() {
          com = false;
        });
        showAlertDialog(context, z);
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
      // backgroundColor: Color(0xff203152),
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width * 1,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(children: [
                    Text(
                      "Step1",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                          //decoration: TextDecoration.underline
                          ),
                    ),
                  ])),
              SingleChildScrollView(
                child: Container(
                  //height: size.height * 0.69,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Text(
                              "Create a new Account:",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Dancing",
                                // fontWeight: FontWeight.bold,
                                color: Color(0xFF776464),
                                //color: Colors.black12,
                              ),
                            )
                          ],
                        ),
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
                            //  color: Color(0xFFFF0000),
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
                            obscureText: true,
                            validator: (val) {
                              return val.length > 4
                                  ? null
                                  : "Enter Password 4+ characters";
                            },
                            controller: vendorpassword,
                            decoration: InputDecoration(
                                icon: Icon(Icons.remove_red_eye),
                                hintText: "Password",
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
                            //  color: Color(0xFFFF0000),
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
                            obscureText: true,
                            validator: (val) {
                              return val == vendorpassword.text
                                  ? null
                                  : "Password not matched";
                            },
                            controller: confirmpassword,
                            decoration: InputDecoration(
                                icon: Icon(Icons.remove_red_eye),
                                hintText: "Confirm Password",
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
                              return val.length == 10 || val.length == 11
                                  ? null
                                  : "Enter Correct hotel Phone number";
                            },
                            controller: hotelphonenumber,
                            decoration: InputDecoration(
                                icon: Icon(Icons.phone_android),
                                hintText: "Hotel phone no.",
                                border: InputBorder.none),
                          ),
                        ),
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
                  singUp(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red,
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

//Step 2 code..

class Step2 extends StatefulWidget {
  var hotel_uid;

  Step2({this.hotel_uid});

  @override
  _Step2State createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  File food_licence,
      business_licence,
      pan_card,
      gst_certificate,
      blank_cheque,
      profile_pic;

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text(" Please upload full details"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

//uploa 2 data .
  additem() async {
    final String apiUrl =
        "https://treato.co.in/api/vendor/add_item/"; //can we call getitem in setstate..?

    Map<String, String> map = {
      "hotel_uid": widget.hotel_uid.toString(),
    };

    print(map);
    var uri = Uri.parse(apiUrl);

    final request = http.MultipartRequest('POST', uri)..fields.addAll(map);
    // ..files.add(await http.MultipartFile.fromPath(
    //     'item_image',
    //     itemimage
    //         .path)); //this is where you add image filepath ok it mean we are

    var response = await request.send();
    print("request");
    print(request);

    final respStr =
        await response.stream.bytesToString(); //post image parametrs there
    print(respStr);

    return jsonDecode(respStr);
  }

  uploadstep2() async {
    if (food_licence != null &&
        business_licence != null &&
        pan_card != null &&
        blank_cheque != null &&
        profile_pic != null) {
      final String apiUrl = "https://treato.co.in/api/vendor/registration_s2/";

      var map = Map<String, String>();
      map["hotel_uid"] = widget.hotel_uid.toString();
      // map["food_licence"] = food_licence.toString();
      // map["business_licence"] = business_licence.toString();
      // map["pan_card"] = pan_card.toString();
      // map["gst_certi"] = gst_certificate.toString();
      // map["blank_cheque"] = blank_cheque.toString();
      // map["passport_photo"] = profile_pic.toString();

      //final response = await http.post(apiUrl, body: map);

      print(map);
      var uri = Uri.parse(apiUrl);

      final request = http.MultipartRequest('POST', uri)
        ..fields.addAll(map)
        ..files.add(await http.MultipartFile.fromPath(
            'food_licence',
            food_licence
                .path)) //this is where you add image filepath ok it mean we are

        ..files.add(await http.MultipartFile.fromPath(
            'business_licence', business_licence.path))
        ..files
            .add(await http.MultipartFile.fromPath('pan_card', pan_card.path))
        ..files.add(await http.MultipartFile.fromPath(
            'gst_certi', gst_certificate.path))
        ..files.add(await http.MultipartFile.fromPath(
            'blank_cheque', blank_cheque.path))
        ..files.add(await http.MultipartFile.fromPath(
            'passport_photo', profile_pic.path));

      var response = await request.send();
      print("request");
      print(request);

      final respStr =
          await response.stream.bytesToString(); //post image parametrs there
      print(respStr);

      //return jsonDecode(respStr);

      if (response.statusCode == 200) {
        print(widget.hotel_uid.toString());
        // print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Step3(hotel_uid: widget.hotel_uid.toString())));
      }
    } else {
      print("provides whole things");
      setState(() {
        com = false;
      });
      showAlertDialog();
    }
  }

  Future<void> getfoodlicence() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropfoodlicence(image);
  }

  cropfoodlicence(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      food_licence = croppedImage;
    });
  }

  Future<void> getbusinesslicence() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropbusinesslicence(image);
  }

  cropbusinesslicence(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      business_licence = croppedImage;
    });
  }

  Future<void> getpancard() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    croppancard(image);
  }

  croppancard(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      pan_card = croppedImage;
    });
  }

  Future<void> getgstcertificate() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropgstcertificate(image);
  }

  cropgstcertificate(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      gst_certificate = croppedImage;
    });
  }

  Future<void> getblankcheque() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropblankcheque(image);
  }

  cropblankcheque(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      blank_cheque = croppedImage;
    });
  }

  Future<void> getprofilepic() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropprofilepic(image);
  }

  cropprofilepic(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      profile_pic = croppedImage;
    });
  }

  step2ok() async {
    if (formKey.currentState.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Step3(
                    hotel_uid: widget.hotel_uid,
                  )));
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Step3(hotel_uid: widget.hotel_uid)));
    // uploaduserprofile();
  }

  bool com = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff203152),
      appBar: AppBar(
          title: Text("Registration"), backgroundColor: Color(0xFF8d0101)),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(17.0),
            child: Row(children: [
              Text(
                "Business Details ..",
                style: TextStyle(
                  fontSize: 20,
                  // fontWeight: FontWeight.bold
                  //decoration: TextDecoration.underline
                ),
              ),
            ])),
        Container(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NOTICE :  Upload your Business Details(it's  necessary to upload all documents except Gst Certificate otherwise your acount will not be save)",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            getfoodlicence();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              height: size.height * 0.3,
              width: size.width * 1,
              child: Card(
                child: food_licence == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Food Licence"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        food_licence,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getbusinesslicence();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: business_licence == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Food Business Licence"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        business_licence,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getpancard();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: pan_card == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Pan Card"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        pan_card,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getgstcertificate();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: gst_certificate == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Gst Certificate"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        gst_certificate,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getblankcheque();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: blank_cheque == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Blank cheque"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        blank_cheque,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getprofilepic();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: profile_pic == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload Passport photo"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        profile_pic,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        com ? CircularProgressIndicator() : Text(""),
        GestureDetector(
          onTap: () {
            setState(() {
              com = true;
            });
            uploadstep2();
            //step2ok();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF8d0101),
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}

//step 3

class Step3 extends StatefulWidget {
  final String hotel_uid;
  Step3({@required this.hotel_uid});

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  File hotelicon, hotelimg1, hotelimg2, hotelimg3;
  bool yesnonveg = true;
  bool nononveg = false;
  bool yesveg = true;
  bool noveg = false;
  bool yesboth = true;
  bool noboth = false;
  String hoteltype;

  uploadstep3() async {
    if (hotelicon != null &&
        hotelimg1 != null &&
        hotelimg2 != null &&
        hotelimg3 != null) {
      final String apiUrl = "https://treato.co.in/api/vendor/registration_s3/";

      var map = Map<String, String>();
      map["hotel_uid"] = widget.hotel_uid.toString();
      // map["hotel_logo"] = hotelicon.toString();
      // map["slider1"] = hotelimg1.toString();
      // map["slider2"] = hotelimg2.toString();
      // map["slider3"] = hotelimg3.toString();
      map["hotel_type"] = ht;

      // final response = await http.post(apiUrl, body: map);

      print(map);
      var uri = Uri.parse(apiUrl);

      final request = http.MultipartRequest('POST', uri)
        ..fields.addAll(map)
        ..files.add(await http.MultipartFile.fromPath(
            'hotel_logo',
            hotelicon
                .path)) //this is where you add image filepath ok it mean we are

        ..files
            .add(await http.MultipartFile.fromPath('slider1', hotelimg1.path))
        ..files
            .add(await http.MultipartFile.fromPath('slider2', hotelimg2.path))
        ..files
            .add(await http.MultipartFile.fromPath('slider3', hotelimg3.path));

      var response = await request.send();
      print("request");
      print(request);

      final respStr =
          await response.stream.bytesToString(); //post image parametrs there
      print(respStr);

      if (response.statusCode == 200) {
        print(widget.hotel_uid.toString());
        //print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Step4(hotel_uid: widget.hotel_uid.toString())));
      }
    } else {
      print("provides whole things");
      setState(() {
        com = false;
      });
      showAlertDialog();
    }
  }

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text(" Please upload full details"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Future<void> gethotelicon() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    crophotelicon(image);
  }

  crophotelicon(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      hotelicon = croppedImage;
    });
  }

  Future<void> getimg1() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropimg1(image);
  }

  cropimg1(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      hotelimg1 = croppedImage;
    });
  }

  Future<void> getimg2() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropimg2(image);
  }

  cropimg2(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      hotelimg2 = croppedImage;
    });
  }

  Future<void> getimg3() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    cropimg3(image);
  }

  cropimg3(File image) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path, compressQuality: 40);

    setState(() {
      hotelimg3 = croppedImage;
    });
  }

  int selectedRadioTile, selectedRadio, selectedRadio1;
  String ht;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio1 = 0;
    selectedRadio = 0;

    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  bool com = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Color(0xff203152),
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
            padding: const EdgeInsets.all(17.0),
            child: Row(children: [
              Text(
                "Step3  . . .",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ])),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "NOTE   :  Upload your Hotel Details  (it's Necessary to upload all documents otherwise your Account is not consider)",
            style: TextStyle(color: Colors.black),
          ),
        ),
        GestureDetector(
          onTap: () {
            gethotelicon();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: hotelicon == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload hotel logo"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        hotelicon,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getimg1();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: hotelimg1 == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload 1st Slider Image"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        hotelimg1,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getimg2();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: hotelimg2 == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload 2nd Slider image"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        hotelimg2,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            getimg3();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: size.height * 0.3,
              width: size.width * 1,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
              ),
              child: Card(
                child: hotelimg3 == null
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: size.height * 0.1),
                          Text("upload 3rd Slider image"),
                          SizedBox(height: 20),
                          Icon(Icons.add_a_photo)
                        ],
                      ))
                    : Image.file(
                        hotelimg3,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              " Hotel Type ",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF8d0101),
              ),
            ),
          ),
        ),
        SizedBox(height: 1),
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
              child: Column(
                children: [
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text("Non Veg"),
                    onChanged: (val) {
                      print(" non yes");
                      setState(() {
                        ht = "Non veg";
                      });
                      setSelectedRadioTile(val);
                    },
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text("Veg"),
                    onChanged: (val) {
                      print("yes veg");
                      setState(() {
                        ht = "Veg";
                      });
                      setSelectedRadioTile(val);
                    },
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 3,
                    groupValue: selectedRadioTile,
                    title: Text("Both"),
                    onChanged: (val) {
                      setState(() {
                        ht = "Both";
                      });
                      print("yesboth");
                      setSelectedRadioTile(val);
                    },
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                ],
              )),
        ),
        com ? CircularProgressIndicator() : Text(""),
        GestureDetector(
          onTap: () {
            setState(() {
              com = true;
            });

            uploadstep3();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF8d0101),
                child: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        SizedBox(height: 50)
      ])),
    );
  }
}
