import 'dart:convert';

import "package:flutter/material.dart";

import "package:http/http.dart" as http;
import 'package:loginui/Regestraion%20screen/step5.dart';
import "package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart";

// final formKey = GlobalKey<FormState>();

class Step4 extends StatefulWidget {
  final String hotel_uid;
  Step4({@required this.hotel_uid});
  @override
  _Step4State createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  TextEditingController mondaytocontroller = TextEditingController();
  TextEditingController mondayfromcontroller = TextEditingController();
  TextEditingController tuuesdaytocontroller = TextEditingController();
  TextEditingController tuesdayfromcontroller = TextEditingController();
  TextEditingController wensdaytocontroller = TextEditingController();
  TextEditingController wensdayfromcontroller = TextEditingController();
  TextEditingController thursdaytocontroller = TextEditingController();
  TextEditingController thursdayfromcontroller = TextEditingController();
  TextEditingController fridaytocontroller = TextEditingController();
  TextEditingController fridayfromcontroller = TextEditingController();
  TextEditingController suturdaytocontroller = TextEditingController();
  TextEditingController suturdayfromcontroller = TextEditingController();
  TextEditingController sundaytocontroller = TextEditingController();
  TextEditingController sundayfromcontroller = TextEditingController();

  step4data(BuildContext context) async {
    if (mondayfrom != null &&
        tuesdayfrom != null &&
        wensdayfrom != null &&
        thursdayfrom != null &&
        fridayfrom != null &&
        suturdayfrom != null &&
        sundayfrom != null &&
        mondayto != null &&
        tuesdayto != null &&
        wensdayto != null &&
        thursdayto != null &&
        fridayto != null &&
        suturdayto != null &&
        sundayto != null) {
      String apiUrl = "https://treato.co.in/api/vendor/registration_s4/";

      var map = Map<String, dynamic>();

      map["hotel_uid"] = widget.hotel_uid;
      map["monday_from"] = mondayfromcontroller.text;
      map["monday_to"] = mondaytocontroller.text.toString();
      map["tuesday_to"] = tuuesdaytocontroller.text.toString();
      map["tuesday_from"] = tuesdayfromcontroller.text.toString();
      map["wednesday_from"] = wensdayfromcontroller.text.toString();
      map["wednesday_to"] = wensdaytocontroller.text.toString();
      map["thursday_to"] = thursdaytocontroller.text.toString();
      map["thursday_from"] = thursdayfromcontroller.text.toString();
      map["friday_from"] = fridayfromcontroller.text.toString();
      map["friday_to"] = fridaytocontroller.text.toString();
      map["saturday_to"] = suturdaytocontroller.text.toString();
      map["saturday_from"] = suturdayfromcontroller.text.toString();
      map["sunday_to"] = sundaytocontroller.text.toString();
      map["sunday_from"] = sundayfromcontroller.text.toString();

      final response = await http.post(apiUrl, body: map);

      Map data;
      data = json.decode(response.body);
      String x = data["result"];

      if (response.statusCode == 200) {
        print(response.body);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Step5(
                      hotel_uid: widget.hotel_uid,
                    )));
      } else {
        print(response.statusCode);
        print("wrong");
      }
    } else {
      print("missing");
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
      content: Text(" Please update each day timing"),
      actions: [okbtn],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  String mondayfrom,
      tuesdayfrom,
      wensdayfrom,
      thursdayfrom,
      fridayfrom,
      suturdayfrom,
      sundayfrom,
      mondayto,
      tuesdayto,
      wensdayto,
      thursdayto,
      fridayto,
      suturdayto,
      sundayto;

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay picked;

  Future<Null> mondayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      mondayfrom = _time.hour.toString();
      mondayfrom = mondayfrom + ":" + _time.minute.toString();
      print(mondayfrom);
    });
  }

  Future<Null> tuesdayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      tuesdayfrom = _time.hour.toString();
      tuesdayfrom = tuesdayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> wensdayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      wensdayfrom = _time.hour.toString();
      wensdayfrom = wensdayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> thursdayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      thursdayfrom = _time.hour.toString();
      thursdayfrom = thursdayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> fridayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      fridayfrom = _time.hour.toString();
      fridayfrom = fridayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> suturdayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      suturdayfrom = _time.hour.toString();
      suturdayfrom = suturdayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> sundayf(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      sundayfrom = _time.hour.toString();
      sundayfrom = sundayfrom + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> sundayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      sundayto = _time.hour.toString();
      sundayto = sundayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> suturdayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      suturdayto = _time.hour.toString();
      suturdayto = suturdayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> fridayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      fridayto = _time.hour.toString();
      fridayto = fridayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> wensdayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      wensdayto = _time.hour.toString();
      wensdayto = wensdayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> thursdayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      thursdayto = _time.hour.toString();
      thursdayto = thursdayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> tuesdayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      tuesdayto = _time.hour.toString();
      tuesdayto = tuesdayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  Future<Null> mondayt(BuildContext context) async {
    picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );

    setState(() {
      _time = picked;
      mondayto = _time.hour.toString();
      mondayto = mondayto + ":" + _time.minute.toString();
      print(_time.hour);
    });
  }

  bool com = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //  backgroundColor: Color(0xff203152),
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: size.width * 1,
            child: Column(children: [
              // IconButton(
              //   icon: Icon(Icons.alarm),
              //   onPressed: () {
              //     mondayf(context);
              //     print(_time);
              //   },
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Your  Hotel Timing",
                      style: TextStyle(
                          // color: Color(0xFFFF0000),
                          fontSize: 20,
                          color: Color(0xFF8d0101)),
                    )),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Step4  . . . .",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("MONDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  mondayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          mondayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      mondayf(context);
                      print(_time);
                    },
                  ),
                  Text("        --->       "),
                  mondayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          mondayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      mondayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("TUESDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  tuesdayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          tuesdayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      tuesdayf(context);
                      print(_time);
                    },
                  ),
                  Text("       --->       "),
                  tuesdayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          tuesdayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      tuesdayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("WEDNESDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  wensdayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          wensdayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      wensdayf(context);
                      print(_time);
                    },
                  ),
                  Text("       --->       "),
                  wensdayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          wensdayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      wensdayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("THURSDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  thursdayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          thursdayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      thursdayf(context);
                      print(_time);
                    },
                  ),
                  Text("        --->       "),
                  thursdayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          thursdayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      thursdayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("FRIDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  fridayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          fridayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      fridayf(context);
                      print(_time);
                    },
                  ),
                  Text("       --->       "),
                  fridayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          fridayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      fridayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("SATURDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  suturdayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          suturdayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      suturdayf(context);
                      print(_time);
                    },
                  ),
                  Text("       --->      "),
                  suturdayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          suturdayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      suturdayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("SUNDAY"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(children: [
                  sundayfrom == null
                      ? Text(
                          "from",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          sundayfrom,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      sundayf(context);
                      print(_time);
                    },
                  ),
                  Text("      --->       "),
                  sundayto == null
                      ? Text(
                          "to",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        )
                      : Text(
                          sundayto.toString(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                  SizedBox(width: 20),
                  IconButton(
                    icon: Icon(Icons.alarm),
                    onPressed: () {
                      sundayt(context);
                      print(_time);
                    },
                  ),
                ]),
              ),
              SizedBox(height: 20),
              com ? CircularProgressIndicator() : Text(""),
              GestureDetector(
                onTap: () {
                  setState(() {
                    com = true;
                  });
                  step4data(context);
                },
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF8d0101),
                      radius: 25,
                      child: Icon(Icons.arrow_forward),
                    )),
              ),
              SizedBox(height: 20)
            ])),
      ),
    );
  }
}
