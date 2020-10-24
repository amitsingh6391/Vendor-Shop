import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:intro_slider/slide_object.dart';
import 'package:loginui/Regestraion%20screen/step123screen.dart';
import 'package:loginui/Regestraion%20screen/step4.dart';
import 'package:loginui/Regestraion%20screen/step5.dart';
import 'package:loginui/pages/allorderspage.dart';
import 'package:loginui/pages/pendingpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "user_modal.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intro_slider/intro_slider.dart';
import 'dart:io';
import "package:flutter_offline/flutter_offline.dart";
import 'package:connectivity/connectivity.dart';

bool connected;

final formKey = GlobalKey<FormState>();
final loginformKey = GlobalKey<FormState>();

String hotel_uid;

UserModel profile;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String intro;

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 5),
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        SharedPreferences preferences = await SharedPreferences.getInstance();

        var email = preferences.getString('email');

        var introexit = preferences.getString("logout");
        print(introexit);
        print(email);
        print("aooooo");

        if (email == "introcomp") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage()));
        }
        if (email == "loggedin") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Detailpage()));
        }

        if (email != "loggedin" && email == null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => IntroScreen()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xfff5a623),
      backgroundColor: Color(0xA2F50808),
      body: Container(
          height: size.height * 1,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("images/appicon.png"),
                  radius: size.width * .4,
                ),
              ),
              
              SizedBox(
                height: size.height * 0.07,
              ),
              CircularProgressIndicator(
                strokeWidth: 5,
                backgroundColor: Colors.white,
              )
            ])),
          )),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UserModel _userinfo;
  final TextEditingController loginnumber = TextEditingController();
  final TextEditingController loginpassword = TextEditingController();

  bool x = false;

  bool com = false;

  Future createUser(var loginnumber, var loginpassword) async {
    if (loginformKey.currentState.validate()) {
      final String apiUrl = "https://treato.co.in/api/vendor/login/";

      var map = Map<String, dynamic>();
      map["text_mobile"] = loginnumber;
      map["text_password"] = loginpassword;

      final response = await http.post(apiUrl, body: map);
      final String responseString = response.body;

      if (response.statusCode == 200) {
        final String responseString = response.body;

        print(responseString);

        return userModelFromJson(responseString);
      } else {
        print("error");
        return null;
      }
    } else {
      setState(() {
        com = false;
      });
    }
  }

  showAlertDialog() {
    Widget okbtn = FlatButton(
      child: Text("Retery"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text("Invalid Email or Password "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  netoff() {
    Widget okbtn = FlatButton(
      child: Text("Retry"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Failed"),
      content: Text(" Please ON your internet connection !! "),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }
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
            body: SingleChildScrollView(
          child: Container(
            // color: Colors.red,
            height: size.height * 1,
            width: size.width * 1,
            child: Column(
              children: [
                Container(
                  // color: Colors.blue,
                  height: size.height * 0.75,
                  width: size.width * 1,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.35,
                        width: size.width * 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF8d0101),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(-10),
                                  bottomRight: Radius.circular(-10)),
                            ),
                            child: Column(children: [
                              SizedBox(height: size.height * 0.07),
                              Text("Treato",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white))
                            ])),
                      ),
                      Form(
                        key: loginformKey,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 108.0, left: 20, right: 20),
                          child: Container(
                            height: size.height * 0.8,
                            width: size.width * 1,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3))
                                ]),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.05),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text("Login",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: size.height * 0.07),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    // SizedBox(width: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 8,
                                          bottom: 8,
                                          right: 6),
                                      child: Icon(Icons.phone_android),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: loginnumber,
                                        decoration: InputDecoration(
                                            hintText:
                                                "Enter Vendor Mobile no.              ",
                                            hintStyle: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            border: InputBorder.none),
                                        validator: (val) {
                                          return val.length == 10
                                              ? null
                                              : "Enter valid Vendor(10 digit number) number";
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 8,
                                          bottom: 8,
                                          right: 6),
                                      child: Icon(Icons.lock),
                                    ),
                                    //  SizedBox(width: 10),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: loginpassword,
                                        decoration: InputDecoration(
                                            hintText:
                                                " Enter your Password             ",
                                            hintStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
                                            labelStyle: TextStyle(
                                                decoration:
                                                    TextDecoration.underline),
                                            border: InputBorder.none),
                                        validator: (val) {
                                          return val.length > 3
                                              ? null
                                              : "Enter valid password";
                                        },
                                      ),
                                    ),
                                  ]),
                                ),

                                com ? CircularProgressIndicator() : Text(""),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF8d0101),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: FlatButton(
                                          onPressed: () async {
                                            setState(() {
                                              com = true;
                                            });
                                            final String lognumber =
                                                loginnumber.text;
                                            final String logpassword =
                                                loginpassword.text;

                                            if (string == "Offline") {
                                              netoff();
                                            } else {
                                              print("ok");
                                            }

                                            final UserModel user =
                                                await createUser(
                                                    lognumber, logpassword);

                                            setState(() {
                                              hotel_uid = user.hotelUid;
                                              _userinfo = user;
                                              profile = user;

                                              if (_userinfo.step ==
                                                  "Completed") {
                                                setState(() {
                                                  com = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Detailpage(
                                                                // hotel_id: hotel_uid,
                                                                )));
                                              } else if (_userinfo.step ==
                                                  "step2") {
                                                setState(() {
                                                  com = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Step2(
                                                              hotel_uid:
                                                                  hotel_uid,
                                                            )));
                                              } else if (_userinfo.step ==
                                                  "step3") {
                                                setState(() {
                                                  com = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Step3(
                                                              hotel_uid:
                                                                  hotel_uid,
                                                            )));
                                              } else if (_userinfo.step ==
                                                  "step4") {
                                                setState(() {
                                                  com = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Step4(
                                                              hotel_uid:
                                                                  hotel_uid,
                                                            )));
                                              } else if (_userinfo.step ==
                                                  "step5") {
                                                setState(() {
                                                  com = false;
                                                });
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Step5(
                                                              hotel_uid:
                                                                  hotel_uid,
                                                            )));
                                              } else {
                                                setState(() {
                                                  com = false;
                                                });
                                                showAlertDialog();
                                              }
                                            });

                                            SharedPreferences preferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'hotel_uid', hotel_uid);

                                            SharedPreferences
                                                preferencesvendormobile =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'vendor_mobile',
                                                user.vendorMobile);

                                            SharedPreferences
                                                preferencesvendoremail =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'vendor_email',
                                                _userinfo.vendorEmail);

                                            SharedPreferences
                                                preferencesvendorname =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'vendor_name', user.vendorName);

                                            SharedPreferences
                                                preferencesvendortype =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'vendor_type', user.vendorType);

                                            SharedPreferences
                                                preferenceshotelname =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'hotel_name', user.hotelName);

                                            SharedPreferences
                                                preferenceshotelmobile =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'hotel_mobile',
                                                user.hotelMobile);

                                            SharedPreferences
                                                preferenceshotelphone =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'hotel_phone', user.hotelPhone);

                                            SharedPreferences
                                                preferenceshotelemail =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'hotel_email', user.hotelMail);

                                            SharedPreferences
                                                preferenceshotellogo =
                                                await SharedPreferences
                                                    .getInstance();
                                            preferences.setString(
                                                'vendor_uid', user.vendorUid);
                                          },
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                ),
                                // com ? CircularProgressIndicator() : Text("")
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // color:Colors.red,
                  height: size.height * 0.2,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.06,
                      ),
                      Row(children: [
                        SizedBox(width: size.width * 0.17),
                        Text("Don't Have an Account:  ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF8d0101),
                            )),
                        GestureDetector(
                            onTap: () {
                              if (string == "Offline") {
                                netoff();
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Step1()));
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Step1()));
                            },
                            child: Container(
                              //width: size.width * 0.4,
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 15,
                                    decoration: TextDecoration.underline),
                              ),
                            ))
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}

class MyConnectivity {
  MyConnectivity._internal();

  static final MyConnectivity _instance = MyConnectivity._internal();

  static MyConnectivity get instance => _instance;

  Connectivity connectivity = Connectivity();

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    ConnectivityResult result = await connectivity.checkConnectivity();
    _checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    controller.sink.add({result: isOnline});
  }

  void disposeStream() => controller.close();
}

class Detailpage extends StatefulWidget {
  // final String hotel_id;
  // Detailpage({@required this.hotel_id});
  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  var pages = [
    PendingPage(),
    OrederPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                Icon(Icons.home, size: 35, color: Colors.white),
                Text("Home",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                Icon(Icons.food_bank, size: 35, color: Colors.white),
                Text(
                  "All Orders",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(height: 10),
                Icon(Icons.account_box, size: 35, color: Colors.white),
                Text(
                  "Profile",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
          color: Color(0xFF8d0101),
          buttonBackgroundColor: Color(0xFF8d0101),
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: pages[_page]);
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email = "";
  String vendorname,
      vendormobile,
      vendoremail,
      vendortype,
      hotelname,
      hotelmobile,
      hotelphone,
      hotelmail,
      hotollogo;

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      vendormobile = preferences.getString('vendor_mobile');
      vendoremail = preferences.getString('vendor_email');
      vendortype = preferences.getString('vendor_type');
      vendorname = preferences.getString('vendor_name');
      hotelmobile = preferences.getString('hotel_mobile');
      hotelphone = preferences.getString('hotel_phone');
      hotelmail = preferences.getString('hotel_email');
      hotollogo = preferences.getString("hotel_logo");
      hotelname = preferences.getString("hotel_name");
    });
  }

  @override
  void initState() {
    super.initState();
    getEmail();
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
          body: SingleChildScrollView(
            child: Container(
              //height: size.height * 1,
              width: size.width * 1,
              child: Column(
                children: <Widget>[
                  Container(
                    color: Color(0xFF8d0101),
                    width: size.width * 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 66.0),
                        child: Text("PROFILE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    // height: size.height * 0.4,
                    width: size.width * 1,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.235,
                          width: size.width * 1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF8d0101),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              // height: size.height * 0.3,
                              width: size.width * 1,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3))
                                  ]),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height * 0.05),
                                    Row(children: [
                                      SizedBox(width: size.width * 0.28),
                                      CircleAvatar(
                                        radius: size.width * 0.15,
                                        backgroundImage:
                                            AssetImage("images/appicon.png"),
                                      ),
                                    ]),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(vendorname,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(vendoremail,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: size.height * 0.,
                  // ),
                  Container(
                      width: size.width * 1,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child: Icon(Icons.person,
                                        color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(vendortype,
                                    style: TextStyle(
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child:
                                        Icon(Icons.hotel, color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(hotelname,
                                    style: TextStyle(
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),
                          //  SizedBox(height: size.height * 0.04),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child:
                                        Icon(Icons.phone, color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(vendormobile,
                                    style: TextStyle(
                                      fontSize: 15,
                                      //  fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child: Icon(Icons.phone_android,
                                        color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("hotel no: $hotelmobile",
                                    style: TextStyle(
                                      fontSize: 15,
                                      //  fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child:
                                        Icon(Icons.phone, color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("hotel phone: $hotelphone",
                                    style: TextStyle(
                                      fontSize: 15,
                                      //  fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),

                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                    backgroundColor: Color(0xFF8d0101),
                                    radius: 25,
                                    child: Icon(Icons.email_rounded,
                                        color: Colors.white)),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("hotel email: $hotelmail",
                                    style: TextStyle(
                                      fontSize: 15,
                                      //  fontWeight: FontWeight.bold
                                    )),
                              )
                            ],
                          ),
                          // SizedBox(height: size.height * 0.04),
                          GestureDetector(
                            onTap: () async {
                              // logOut(context);
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setString('email', "introcomp");

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage()));
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      backgroundColor: Color(0xFF8d0101),
                                      radius: 25,
                                      child: Icon(Icons.logout,
                                          color: Colors.white)),
                                ),
                                SizedBox(width: size.width * 0.05),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("LOGOUT",
                                      style: TextStyle(
                                        fontSize: 15,
                                        // fontWeight: FontWeight.bold
                                      )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}

//introsreen...

class IntroScreen extends StatefulWidget {
  // IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  getintro() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setBool('intro', false);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', "introcomp");
  }

  //  SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('email', "loggedin");

  @override
  void initState() {
    getintro();

    super.initState();

    slides.add(
      new Slide(
        title: "Treato",
        description:
            "Vendor Shop India Most loving Vendor app . Create your Account and start sell your Products now.",
        pathImage: "images/intro1.png",
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: "Track Orders",
        description:
            "See Your All Order in One place in One Click , easy to handel them",
        pathImage: "images/intro3.jpg",
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: "Easy To Manage",
        description: "Manage Your Pending Orders and Explore Your Business",
        pathImage: "images/intro2.jpg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }

  void onDonePress() {
// Do what you want

    //Splashscreen();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
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
      child: new IntroSlider(
        slides: this.slides,
        onDonePress: this.onDonePress,
      ),
    );
  }
}
