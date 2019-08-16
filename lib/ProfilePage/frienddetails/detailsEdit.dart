import 'package:flutter/material.dart';
import 'package:startupreneur/ProfilePage/friends/friend.dart';
import 'package:startupreneur/home.dart';
import 'package:startupreneur/timeline/MainRoadmap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:startupreneur/progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import '../ProfilePageLoader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

class EditDetail extends StatefulWidget {
  EditDetail({Key key,this.user}):super(key:key);
  Friend user;
  @override
  _EditDetailState createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> with AutomaticKeepAliveClientMixin{

  static Friend currentuser;
  static var _value = null;
  static FirebaseUser user;
  static PDFDocument doc;
  static SharedPreferences sharedPreferences;
  static ProgressDialog progressDialog;
  static final _formkey = GlobalKey<FormState>();
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
  static var fname = "     ";
  static var email = "";
  static var mobile = "";
  static var gender = null;
  static var _password = "";
  static var _confirmPassword = "";
  static var institutionOrCompany = "";
  static var typeOfOccupations = "";
  static var referalCodeFromFriend = "", userid = "";
  static Firestore db = Firestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static File file;

  // static _pdfworks() async {
  //   print("hello world");
  //   doc = await PDFDocument.fromAsset('assets/pdf/t_and_c.pdf');
  // }

  // static _preferences(String userid) async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setString("UserId", userid);
  //   sharedPreferences.setString("UserEmail", email);
  // }

  // static void signUpInwithEmail(BuildContext context) async {
  //   progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
  //   progressDialog.setMessage("Saving data..");
  //   try {
  //     progressDialog.show();
  //     user = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: _password,
  //     );
  //     progressDialog.hide();
  //     user = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: _password,
  //     );
  //     userid = user.uid;
  //    // _preferences(userid);
  //     print("its is $user");
  //     createNote();
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => new TimelinePage(title: "Time line"),
  //     ));
  //   } catch (e) {
  //     progressDialog.hide();
  //     Toast.show("Sign up failed, please try again", context,
  //         gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
  //   } finally {
  //     if (user != null) {}
  //   }
  // }

  static void createNote(BuildContext context) async {
    progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Saving data..");
     progressDialog.show();
    var dataMap = new Map<String, dynamic>();
    dataMap['name'] = fname;
    dataMap['email'] = email;
    dataMap['mobile'] = mobile;
   // dataMap['gender'] = gender;
    dataMap['institutionOrCompany'] = institutionOrCompany;
    dataMap['typeOfOccupations'] = typeOfOccupations;
    //dataMap['referalCodeFromFriend'] = referalCodeFromFriend;
    // dataMap['uid'] = userid;
    // dataMap['points'] = 0;
    //dataMap['completed'] = [1];
    // dataMap['uid'] = userid;
     await db.collection("user").document(currentuser.uid).setData(dataMap,merge: true).catchError((e){
       progressDialog.hide();
      print(e);
    });
     progressDialog.hide();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => new ProfileLoading(uid:currentuser.uid),
      ));
  }

  static bool isValide() {
    final _form = _formkey.currentState;

    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  static validateAndSubmit(BuildContext context) async {
    if (isValide()) {
     // signUpInwithEmail(context);
     createNote(context);
    }
  }
void getFilePath(BuildContext context) async {
   
    //  String _filePath;
    try {
      print("Before pickking file");
      // String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      File file1 = await FilePicker.getFile(type: FileType.ANY);
       progressDialog = new ProgressDialog(context, ProgressDialogType.Normal);
    progressDialog.setMessage("Uploading....");
    progressDialog.show();
      print("File picked successfully");
      if (file1 == null) {
        return;
      }
      print("File path: " + p.basename(file1.path));
      setState(() {
        file = file1;
      });
      upload(context);
      
    } catch (e) {
      progressDialog.hide();
       Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print("Error while picking the file: " + e.toString());
    }
  }

  

  Future upload(BuildContext context) async{
    // FirebaseAuth.instance.currentUser().then((user) {
    //   this.uid = user.uid;
    // });
    String extenstion = p.basename(file.path).split(".")[1];
    final StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child(currentuser.uid)
        .child("resume." + extenstion);

   StorageUploadTask task = storageRef.putFile(file);
    //  if(task.isInProgress){
    //    print("On Progress task");

StorageTaskSnapshot taskSnapshot = await task.onComplete;
String downloadUrl = await taskSnapshot.ref.getDownloadURL();
print("On downloadUrl task"+downloadUrl);

var dataMap = new Map<String, dynamic>();
    dataMap['resume'] = downloadUrl;

await db.collection("user").document(currentuser.uid).setData(dataMap,merge: true).catchError((e){
       progressDialog.hide();
        Toast.show("Upload failed, please try again", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
      print(e);
    });
    //  }
    // if (taskSnapshot.) {
    //   print("On downloadUrl task"+downloadUrl);
    // }
    // if (task.isCanceled) {
    //   print("On isCanceled task");
    // }
    print("Hai");
    progressDialog.hide();
  //  Scaffold.of(context).showSnackBar( SnackBar(
  //       content: Text("Resume uploaded "),
  //       duration: Duration(seconds: 3),
  //     )
  //  );
  Toast.show("Resume Uploaded Successfully", context,
          gravity: Toast.BOTTOM, duration: Toast.LENGTH_LONG);
    //  List<dynamic> arguments = [widget.modNum, widget.index + 1];
    //         orderManagement.moveNextIndex(context, arguments);

  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // textEditingController.addListener((){

    //   print(textEditingController.text);

    // });
    setState(() {
      currentuser = widget.user;
      textEditingController1.text = currentuser.name;
      textEditingController2.text = currentuser.email;
      textEditingController3.text = currentuser.mobile;
      textEditingController5.text = currentuser.occupation;
      textEditingController4.text = currentuser.institution;
      print("init state");
    });
   
    print(currentuser.name);
  }

  Widget fullName(BuildContext context) => TextFormField(
       // initialValue:"fname",//"${currentuser.name}",
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
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          labelText: "Full Name *",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget emailAddress(BuildContext context) => TextFormField(
    // initialValue: "${currentuser.email}",
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
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          labelText: "Email Address *",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget mobileNumber(BuildContext context) => TextFormField(
    // initialValue: "${currentuser.mobile}",
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
          hintText: "9485621288",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          labelText: "Mobile Number *",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

  Widget institution_or_company(BuildContext context) => TextFormField(
    // initialValue: "${currentuser.institution}",
        controller: textEditingController4,
        onSaved: (value) {
          setState(() {
            institutionOrCompany = value;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.business, color: Colors.green),
          hintText: "bob school of AI",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          labelText: "Institution/Company",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),

         
        ),
      );

  Widget occupation(BuildContext context) => TextFormField(
    // initialValue: "${currentuser.occupation}",
        controller: textEditingController5,
        onSaved: (value) {
          setState(() {
            typeOfOccupations = value;
          });
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.work, color: Colors.green),
          hintText: "eg Student,business etc",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
          labelText: "Occupation *",
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),

          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green, width: 2.0),
          // ),
        ),
      );

Widget uploadResume(BuildContext context) => ButtonTheme(
        minWidth: 300,
        height: 50,
        buttonColor: Color.fromRGBO(255, 116, 23, 1),
        child: OutlineButton(
         
          borderSide:BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
          // onPressed: validateAndSubmit,
          onPressed: () {
            getFilePath(context);
          },
          child: Text(
            "Upload CV/Resume`",
            style: TextStyle(color: Colors.black, fontSize: 12),
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
            "Confirm",
            style: TextStyle(color: Colors.black, fontSize: 12),
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
      body: Container(
        padding: EdgeInsets.all(20),
        width: 600,
        height: double.infinity,
        // child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              Text(
                "EDIT DETAILS",
                style: TextStyle(
                    fontSize: 20, letterSpacing: 2, fontFamily: "Open Sans"),
              ),
              Padding(
                padding: EdgeInsets.only(left: 200),
              ),
              Text(
                "                ",
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
            
              mobileNumber(context),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
             
              occupation(context),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              institution_or_company(context),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              uploadResume(context),
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
      ),
    );
  }
}
