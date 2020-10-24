import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:loginui/Regestraion%20screen/step4.dart';
import 'package:loginui/Regestraion%20screen/step6.dart';

final step5key = GlobalKey<FormState>();

class Step5 extends StatefulWidget {
  final String hotel_uid;
  Step5({@required this.hotel_uid});
  @override
  _Step5State createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  TextEditingController account_no = TextEditingController();
  TextEditingController ifsc_code = TextEditingController();
  TextEditingController bank_name = TextEditingController();
  TextEditingController bensificry_name = TextEditingController();
  TextEditingController bank_address = TextEditingController();

  bool nocurrent = false, yescurrent = true, nosaving = false, yessaving = true;

  String ac;

  Color sb = Colors.black12;
  Color sbl = Colors.blue;
  Color cb = Colors.black12;
  Color cbl = Colors.blue;

  step5data() async {
    if (step5key.currentState.validate()) {
      final String apiUrl = "https://treato.co.in/api/vendor/registration_s5/";

      var map = Map<String, dynamic>();
      map["hotel_uid"] = widget.hotel_uid;

      map["account_no"] = account_no.text;
      map["ifsc_code"] = ifsc_code.text;
      map["bank_name"] = bank_name.text;
      map["benificiary_name"] = bensificry_name.text;
      map["account_type"] = ac;

      final response = await http.post(apiUrl, body: map);
      if (response.statusCode == 200) {
        print("yes");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Step6(
                      hotel_uid: widget.hotel_uid,
                    )));
      }
    } else {
      print("okk");
      setState(() {
        com = false;
      });
    }
  }

  bool com = false;
  int selectedRadioTile, selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
    print(widget.hotel_uid);
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Color(0xff203152),
      appBar: AppBar(
        title: Text(
          "Registration",
        ),
        backgroundColor: Color(0xFF8d0101),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: step5key,
          child: Container(
              width: size.width * 1,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Step5 . . . . .",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Bank Details",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8d0101))),
                  ),
                  //SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        child: Column(children: [
                      TextFormField(
                        controller: account_no,
                        decoration: InputDecoration(
                          hintText: "    Account Number",
                        ),
                        validator: (val) {
                          return val.length > 9
                              ? null
                              : "Enter Correct Account number";
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: ifsc_code,
                        decoration: InputDecoration(hintText: "     IFSC Code"),
                        validator: (val) {
                          return val.length > 3
                              ? null
                              : "Enter Correct IFSC code";
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: bank_name,
                        decoration:
                            InputDecoration(hintText: "      BANK NAME"),
                        validator: (val) {
                          return val.length > 2
                              ? null
                              : "Enter Correct Bank Name";
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: bensificry_name,
                        decoration:
                            InputDecoration(hintText: "      Beneficiary name"),
                        validator: (val) {
                          return val.length > 4
                              ? null
                              : "Enter Correct beneficiary name";
                        },
                      ),
                      SizedBox(height: 20),
                    ])),
                  ),
                  Text("ACCOUNT TYPE",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8d0101))),
                  SizedBox(height: 10),
                  RadioListTile(
                    value: 1,
                    groupValue: selectedRadioTile,
                    title: Text("Saving"),
                    onChanged: (val) {
                      print("yes");
                      setState(() {
                        ac = "Saving";
                      });
                      setSelectedRadioTile(val);
                    },
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: selectedRadioTile,
                    title: Text("Current"),
                    onChanged: (val) {
                      setState(() {
                        ac = "Current";
                      });
                      print("yescurrent");
                      setSelectedRadioTile(val);
                    },
                    activeColor: Colors.blue,
                    selected: false,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: bank_address,
                      // maxLines: 4,
                      decoration: InputDecoration(
                          hintText: "Bank  Address", labelText: "Bank Address"),

                      validator: (val) {
                        return val.length > 4
                            ? null
                            : "Enter Correct Bank Address";
                      },
                    ),
                  ),
                  com ? CircularProgressIndicator() : Text(""),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        com = true;
                      });
                      step5data();
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
                ],
              )),
        ),
      ),
    );
  }
}
