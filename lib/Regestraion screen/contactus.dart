import 'package:flutter/material.dart';
import 'package:loginui/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class Contactus extends StatelessWidget {
  contact() async {
    final Uri params = Uri(scheme: "mailto", path: "Support@treato.co.in");

    String url = params.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact us",
          ),
          actions: [
            CircleAvatar(
                backgroundColor: back,
                radius: 25,
                child: Icon(Icons.support_agent, color: Colors.white)),
          ],
          backgroundColor: back,
        ),
        body: Container(
            child: Column(children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     onTap: () async {
          //       contact();
          //     },
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: CircleAvatar(
          //               backgroundColor: back,
          //               radius: 25,
          //               child: Icon(Icons.phone, color: Colors.white)),
          //         ),
          //         SizedBox(width: size.width * 0.05),
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text("",
          //               style: TextStyle(
          //                 fontSize: 15,
          //                 // fontWeight: FontWeight.bold
          //               )),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: GestureDetector(
          //     onTap: () async {
          //       contact();
          //     },
          //     child: Row(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: CircleAvatar(
          //               backgroundColor: back,
          //               radius: 25,
          //               child: Icon(Icons.phone_android, color: Colors.white)),
          //         ),
          //         SizedBox(width: size.width * 0.05),
          //         Column(children: [
          //           Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: Text("WhatsApp",
          //                 style: TextStyle(
          //                   fontSize: 15,
          //                   // fontWeight: FontWeight.bold
          //                 )),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(4.0),
          //             child: Text("56667",
          //                 style: TextStyle(
          //                   fontSize: 15,
          //                   // fontWeight: FontWeight.bold
          //                 )),
          //           )
          //         ])
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                contact();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        backgroundColor: back,
                        radius: 25,
                        child: Icon(Icons.mail, color: Colors.white)),
                  ),
                  SizedBox(width: size.width * 0.05),
                  Column(children: [
                    Text("Email"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Support@treato.co.in",
                          style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold
                          )),
                    )
                  ])
                ],
              ),
            ),
          ),
        ])));
  }
}
