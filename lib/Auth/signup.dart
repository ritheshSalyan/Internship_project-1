import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:startupreneur/Analytics/Analytics.dart';
import 'package:startupreneur/NoInternetPage/NoNetPage.dart';
import 'package:startupreneur/home.dart';
import 'package:startupreneur/timeline/MainRoadmapLoader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'PdfReader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with AutomaticKeepAliveClientMixin {
  static FirebaseUser user;
  static SharedPreferences sharedPreferences;
  static ProgressDialog progressDialog;
  static final _formkey = GlobalKey<FormState>();
  FirebaseMessaging _messaging = FirebaseMessaging();
  // static final _fieldKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static TextEditingController textEditingController1 =
      new TextEditingController();
  static TextEditingController textEditingController2 =
      new TextEditingController();
  static TextEditingController textEditingController3 =
      new TextEditingController();
  static TextEditingController textEditingController4 =
      new TextEditingController();
  static TextEditingController textEditingController5 =
      new TextEditingController();
  static TextEditingController textEditingController6 =
      new TextEditingController();
  static TextEditingController textEditingController7 =
      new TextEditingController();
  static TextEditingController textEditingController8 =
      new TextEditingController();

  static bool isChecked = false;
  static var fname = "";
  static var email = "";
  static var mobile = "";
  static var gender;
  static var _password = "";
  // static var _confirmPassword = "";
  static var institutionOrCompany = "";
  static var typeOfOccupations;
  static var referalCodeFromFriend = "", userid = "";
  static Firestore db = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static dynamic referePoint = 0;
  PDFDocument doc;
  static String tokenId = "";
  bool status = false;
  String _documentPath = 'assets/pdf/t_and_c.pdf';

  static _preferences(String userid) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("UserId", userid);
    sharedPreferences.setString("UserEmail", email);
    Analytics.setUserId(userid);
  }

  void signUpInwithEmail(BuildContext context) async {
    bool flag = false;
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Creating Account..");
    progressDialog.show();

    var value;
    await _auth.fetchSignInMethodsForEmail(email: email).then((data) {
      // print(data);
      value = data;
    });
    if (value.isNotEmpty) {
      value.forEach((result) {
        // print(result);
        switch (result) {
          case "ERROR_INVALID_CREDENTIAL":
            Toast.show("Sign up failed, please try again", context,
                gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
            progressDialog.hide();
            break;
          case "ERROR_USER_NOT_FOUND":
            setState(() {
              flag = true;
            });
            break;
          default:
            Toast.show(
                "Email is already in use! Please Login with credientials",
                context,
                gravity: Toast.BOTTOM,
                duration: Toast.LENGTH_LONG);
            progressDialog.hide();
        }
      });
    } else {
      flag = true;
    }

    if (flag) {
      try {
        progressDialog.show();
        user = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: _password,
        );
        // print("Email Verification");
        progressDialog.setMessage("Please Verify Email");
        //await user.sendEmailVerification();
        user = await _auth.signInWithEmailAndPassword(
          email: email,
          password: _password,
        );
        userid = user.uid;
        _preferences(userid);
        // print("its is $user");
        Toast.show("Please Verify your Email id and sign In", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
        if (referalCodeFromFriend.isNotEmpty) {
          await db
              .collection("user")
              .where("uid", isEqualTo: referalCodeFromFriend)
              .getDocuments()
              .then((onValue) {
            onValue.documents.forEach((document) {
              referePoint = document.data["points"];
            });
          });

          var dataMap = new Map<String, dynamic>();
          dataMap['points'] = 5000 + referePoint;
          db
              .collection("user")
              .document(referalCodeFromFriend)
              .setData(dataMap, merge: true);
        }

        createNote();
        setState(() {
          status = true;
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => new RoadmapLoader(
            status: status,
          ),
        ));
      } catch (e) {
        print("ERROR IN SIGNUP:" + e.toString());
        //progressDialog.hide();
        Toast.show("Sign up failed, please try again", context,
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      } finally {
        if (user != null) {}
      }
    }
  }

  static void createNote() async {
    var dataMap = new Map<String, dynamic>();
    dataMap['name'] = fname;
    dataMap['email'] = email;
    dataMap['mobile'] = mobile;
    dataMap['gender'] = gender;
    dataMap['institutionOrCompany'] = institutionOrCompany;
    dataMap['typeOfOccupations'] = typeOfOccupations;
    dataMap['referalCodeFromFriend'] = referalCodeFromFriend;
    dataMap['uid'] = userid;
    dataMap['points'] = 1000;
    dataMap['completed'] = [1, 2];
    dataMap["payment"] = true;
    dataMap["resume"] = "";
    dataMap["hustle"] = [];
    dataMap['profile'] =
        "https://firebasestorage.googleapis.com/v0/b/thestartupreneur-e1201.appspot.com/o/images%2Favatar.png?alt=media&token=d6c06033-ba6d-40f9-992c-b97df1899102";
    // dataMap['uid'] = userid;
    db
        .collection("user")
        .document(userid)
        .setData(dataMap, merge: true)
        .catchError((e) {
      print(e);
    });

    var data = Map<String, dynamic>();
    data["mobToken"] = tokenId;
    db.collection("pushToken").document(userid).setData(data).catchError((e) {
      print(e);
    });
    // db.collection("pushToken").document(userid).add(data).catchError((e){
    //   print(e);
    // });
  }

  static bool isValide() {
    final _form = _formkey.currentState;

    if (isChecked && _form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  validateAndSubmit(BuildContext context) async {
    if (isValide()) {
      signUpInwithEmail(context);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    prepareTestPdf();
    _messaging.getToken().then((token) {
      setState(() {
        tokenId = token;
      });
    });
    Analytics.analyticsBehaviour("Sign_up_page", "SignUp");
  }

  Widget fullName(BuildContext context) => TextFormField(
        controller: textEditingController1,
        validator: (value) => value.isEmpty ? "Name cannot be empty" : null,
        onSaved: (value) {
          setState(() {
            fname = value;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.green),
          hintText: "eg. Bob Marley",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
          labelText: "Full Name *",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget emailAddress(BuildContext context) => TextFormField(
        controller: textEditingController2,
        validator: (value) => value.isEmpty ? "Email cannot be empty" : null,
        onSaved: (value) {
          setState(() {
            email = value;
          });
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Colors.green),
          hintText: "you@example.com",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
          labelText: "Email Address *",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget mobileNumber(BuildContext context) => TextFormField(
        controller: textEditingController3,
        validator: (value) {
          if (value.isEmpty) {
            return "Number cannot be empty";
          } else if (value.length > 10) {
            return "Number not valid";
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            mobile = value;
          });
        },
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone_android, color: Colors.green),
          hintText: "",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
          labelText: "Mobile Number *",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget institution_or_company(BuildContext context) => TextFormField(
        controller: textEditingController4,
        onSaved: (value) {
          setState(() {
            institutionOrCompany = value;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.business, color: Colors.green),
          hintText: "Bob School of AI",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
          labelText: "Institution/Company",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  // Widget occupation(BuildContext context) => TextFormField(
  //       controller: textEditingController5,
  //       onSaved: (value) {
  //         setState(() {
  //           typeOfOccupations = value;
  //         });
  //       },
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         prefixIcon: Icon(Icons.work, color: Colors.green),
  //         hintText: "eg Student,business etc",
  //         hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
  //         labelText: "Occupation *",
  //         labelStyle: TextStyle(color: Colors.black, fontSize: 12),

  //         // focusedBorder: OutlineInputBorder(
  //         //   borderRadius: BorderRadius.circular(10),
  //         //   borderSide: BorderSide(color: Colors.green, width: 2.0),
  //         // ),
  //       ),
  //     );

  Widget occupation = Text(" ");

  Widget referalCode(BuildContext context) => TextFormField(
        controller: textEditingController6,
        validator: (value) {
          if (value.length < 6 && value.length > 6) {
            return "Not valid";
          }
          return null;
        },
        onSaved: (value) {
          setState(() {
            referalCodeFromFriend = value;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.cloud_circle, color: Colors.green),
          hintText: "Ax875b",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          helperText: "CODE FROM YOUR FRIEND",
          helperStyle: TextStyle(
              color: Colors.grey,
              fontStyle: FontStyle.italic,
              letterSpacing: 0.5),
          labelText: "Referral Code",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget password(BuildContext context) => TextFormField(
        controller: textEditingController7,
        validator: (value) {
          if (value.isEmpty) {
            return "Password cannot be empty";
          } else if (value.length < 8) {
            return "password must be atleast 8 in length";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            _password = value;
          });
        },
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Colors.green),
          hintText: "password",
          hintStyle:
              TextStyle(color: Colors.grey, fontSize: 12, letterSpacing: 0.5),
          labelText: "Password *",
          labelStyle:
              TextStyle(color: Colors.black, fontSize: 12, letterSpacing: 0.5),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

//  final confirmPassword = TextFormField(
//    validator: (value){
//      if(value.isEmpty){
//        return "Field cannot be empty";
//      }else if(value == _password){
//        return null;
//      }else{
//        print("The value is $value");
//        print("The password is $_password");
//        return "Password did not match";
//      }
//    },
//    obscureText: true,
//    onSaved: (value) => _confirmPassword = value,
//    keyboardType: TextInputType.text,
//    decoration: InputDecoration(
//      prefixIcon: Icon(Icons.lock_outline, color: Colors.green),
//      hintText: "Confirm Password",
//      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
//      labelText: "Confirm password *",
//      labelStyle: TextStyle(color: Colors.black,fontSize: 12),
//
//      // focusedBorder: OutlineInputBorder(
//      //   borderRadius: BorderRadius.circular(10),
//      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
//      // ),
//    ),
//  );
  void prepareTestPdf() async {
    doc = await PDFDocument.fromAsset(_documentPath);
  }

  Widget signUpButton(BuildContext context) => ButtonTheme(
        minWidth: 300,
        height: 50,
        buttonColor: Color.fromRGBO(255, 116, 23, 1),
        child: RaisedButton(
          elevation: 5,
          color: Colors.green,
          // onPressed: validateAndSubmit,
          onPressed: () {
            validateAndSubmit(context);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                color: Colors.black, fontSize: 12, letterSpacing: 0.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          // borderSide: BorderSide(
          //   width: 1.5,
          //   color: Colors.green,
          //   style: BorderStyle.solid,
          // ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(MaterialPageRoute(builder: (context) => homePage()));
          },
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
//       body:
      body: OfflineBuilder(
        connectivityBuilder:
            (context, ConnectivityResult connectivity, Widget child) {
          final connected = connectivity != ConnectivityResult.none;
          if (connected) {
            child = Container(
              padding: EdgeInsets.all(20),
              width: 600,
              height: double.infinity,
              // child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: ListView(
                  children: <Widget>[
                    Text(
                      "SIGN UP",
                      style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 2,
                          fontFamily: "Open Sans"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 200),
                    ),
                    Text(
                      "           ",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.green,
                          decorationThickness: 5),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    fullName(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    emailAddress(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    password(context),
//              Padding(
////                padding: EdgeInsets.only(top: 20),
////              ),
////              confirmPassword,
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    mobileNumber(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    DropdownButtonFormField<String>(
                      value: gender,
                      validator: (value) =>
                          value.isEmpty ? "Gender cannot be empty" : null,
                      onSaved: (value) => gender = value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.genderless,
                          color: Colors.green,
                        ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: BorderSide(color: Colors.white, width: 2.0),
                        // ),
                      ),
                      hint: Text(
                        "Gender",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                          // print("$gender");
                        });
                      },
                      items: ['Male', 'Female', 'Others'].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    DropdownButtonFormField<String>(
                      value: typeOfOccupations,
                      validator: (value) =>
                          value.isEmpty ? "Occupation cannot be empty" : null,
                      onSaved: (value) => typeOfOccupations = value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.work,
                          color: Colors.green,
                        ),
                        // focusedBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(10),
                        //   borderSide: BorderSide(color: Colors.white, width: 2.0),
                        // ),
                      ),
                      hint: Text(
                        "Select Your Occupation *",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          typeOfOccupations = value;
                          if (typeOfOccupations == "Others") {
                            occupation = TextFormField(
                              controller: textEditingController5,
                              onSaved: (value) {
                                setState(() {
                                  typeOfOccupations = value;
                                });
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.work, color: Colors.green),
                                hintText: "eg Student,business etc",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    letterSpacing: 0.5),
                                labelText: "Occupation *",
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    letterSpacing: 0.5),

                                // focusedBorder: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                //   borderSide: BorderSide(color: Colors.green, width: 2.0),
                                // ),
                              ),
                            );
                          }
                          // print("$typeOfOccupations");
                        });
                      },
                      items: [
                        "Student",
                        "Employed",
                        "Entrepreneur",
                        "Unemployed",
                        "Others"
                      ].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                letterSpacing: 0.5),
                          ),
                        );
                      }).toList(),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20),
                    // ),

                    occupation,

                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    institution_or_company(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    referalCode(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          checkColor: Colors.green,
                          activeColor: Colors.black,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                              // print("$isChecked");
                            });
                          },
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfReader(doc, "Terms and Conditions"),
                                  fullscreenDialog: true),
                            );
                          },
                          child: Text(
                            "Accept Terms & Conditions",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    signUpButton(context),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          }
          return child;
        },
        child: NoNetPage(),
      ),
    );
  }
}
