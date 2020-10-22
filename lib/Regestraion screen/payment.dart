import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  Razorpay razorpay;
  TextEditingController coinEditingController = new TextEditingController();
  // var a = TextEditingController;

  //String userid;
  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_TjJecZ7MfB9igy",
      "amount": num.parse(coinEditingController.text) * 100,
      "description": "Add Money",
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "coins successfully added to your sikka account........" +
            response.paymentId);

    print("Pamyent successful");
    //Uploadcoin2();
// success();
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Fluttertoast.showToast(
        msg: "error" + response.code.toString() + "." + response.message);
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External Wallet" + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Body()));
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.blue[200], Colors.white, Colors.blue[200]]),
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstATop),
                  image: new AssetImage("assets/premium-roulette.gif"))),
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Container(
                height: 400,
                width: 300,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2)),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                        radius: 50,
                        child: Image(
                          image: AssetImage("assets/images (7).png"),
                        )),
                    SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: coinEditingController,
                      decoration: InputDecoration(
                        hintText: "amount to add",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                      ),
                    ),
                    SizedBox(
                      height: 42,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        "Pay Now",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        openCheckout();
                        // setState(() {
                        //   m=m+int.parse(coinEditingController.text);
                        // });
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(),
                  ],
                ),
              ),

//            Container(
//              child: StreamBuilder(
//                stream: Firestore.instance.collection("users").document(userid).snapshots(),
//                builder: (context, snapshot) {
//                  if(!snapshot.hasData){
//                    print("loading");
//                  }
//                  var userdetails = snapshot.data;
//                 // s= coindata["coins"];
//                 // print(s);
////                  username = userdetails["userName"];
////                  useremail = userdetails["userEmail"];
////                  usernumber = userdetails["userphonenumber"];
//                  return Text(
//
//                    userdetails["userName"]
//
//                  );
//                },
//
//
//              ),
//            )
            ],
          ),
        ),
      ),
    );
  }
}
