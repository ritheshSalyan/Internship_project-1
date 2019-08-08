import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
//import 'package:razorpay_plugin/razorpay_plugin.dart';

class PaymentGatewayPage extends StatefulWidget {
  @override
  _PaymentGatewayPageState createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> with AutomaticKeepAliveClientMixin{
  static const platform = const MethodChannel('pay');

  SharedPreferences _sharedPreferences;
  String userId;
  Razorpay _razorpay;
  Firestore  db = Firestore.instance;
  dynamic decision;
  FirebaseAuth _auth = FirebaseAuth.instance;
  PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
//    _razorpay = Razorpay();
//    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _OnSuccessEvent);
//    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _OnErrorEvent);
//    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _OnWalletEvent);
    preference();
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

//  @override
//  void dispose() {
//    super.dispose();
//   _razorpay.clear();
//  }

  void preference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    userId = _sharedPreferences.getString("UserId");
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Text("Are you sure you want to quit? "),
          title: Text(
            "Warning!",
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _sharedPreferences.clear();
                _auth.signOut();
                Navigator.pop(context, true);
              },
            ),
            FlatButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
          ],
        );
      },
    );
  }



  Future<Null> _payment() async {

     await platform.invokeMethod('payment');
    //  print("Message from PaymentGateway.dart RESULT IS VAL IS  $result");
     var data = Map<String,dynamic>();
     data["payment"]=true;
     await db.collection("user").document(userId).setData(data);
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Payment"),
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: PageStorage(
          bucket: bucket,
          child: Column(
            children: <Widget>[
              Card(
                child: Form(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                      ),
                      OutlineButton(
                        onPressed: () {
                          _payment();
                        },
                        child: Text("Pay"),
                      ),
                    ],
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
