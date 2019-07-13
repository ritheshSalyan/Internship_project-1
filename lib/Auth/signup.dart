import 'package:flutter/material.dart';
import 'package:startupreneur/home.dart';
import 'package:startupreneur/timeline/trial.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  static var _value = null;
  static final _formkey = GlobalKey<FormState>();

  static bool isChecked = false;
  static var fname = "";
  static var email = "";
  static var mobile = "";
  static var gender = null;
  static var institutionOrCompany = "";
  static var typeOfOccupations = "";
  static var referalCodeFromFriend = "";

  static bool isValide() {
    final _form = _formkey.currentState;

    if (_form.validate()) {
      _form.save();
      return true;
    }
    return false;
  }

  static validateAndSubmit() async {
    if (isValide()) {
      print("All good");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final fullName = TextFormField(
    validator: (value) => value.isEmpty ? "Name cannot be empty" : null,
    onSaved: (value) => fname = value,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.green),
      hintText: "eg. Bob",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      labelText: "Full Name *",
      labelStyle: TextStyle( color: Colors.white,fontSize: 12),
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );


  final emailAddress = TextFormField(
    validator: (value) => value.isEmpty ? "Email cannot be empty" : null,
    onSaved: (value) => email = value,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.email, color: Colors.green),
      hintText: "you@example.com",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      labelText: "Email Address *",
      labelStyle: TextStyle(color: Colors.white,fontSize: 12),
     
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );

  final mobileNumber = TextFormField(
    validator: (value) {
      if (value.isEmpty) {
        return "Number cannot be empty";
      } else if (value.length > 10) {
        return "Number not valid";
      }
      return null;
    },
    onSaved: (value) => mobile = value,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.phone_android, color: Colors.green),
      hintText: "9485621288",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      labelText: "Mobile Number *",
      labelStyle: TextStyle(color: Colors.white,fontSize: 12),
      
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );

  final institution_or_company = TextFormField(
    onSaved: (value) => institutionOrCompany = value,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.business, color: Colors.green),
      hintText: "bob school of AI",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      labelText: "Institution/Company",
     labelStyle: TextStyle(color: Colors.white,fontSize: 12),
      
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );

  final occupation = TextFormField(
    onSaved: (value) => typeOfOccupations = value,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.work, color: Colors.green),
      hintText: "eg Student,business etc",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      labelText: "Occupation *",
     labelStyle: TextStyle(color: Colors.white,fontSize: 12),
      
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );

  final referalCode = TextFormField(
    onSaved: (value) => referalCodeFromFriend = value,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.cloud_circle, color: Colors.green),
      hintText: "Ax875b",
      hintStyle: TextStyle(color: Colors.grey,fontSize: 12),
      helperText: "6 DIGIT CODE FROM YOUR FRIEND",
      helperStyle: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      labelText: "Referal code",
     labelStyle: TextStyle(color: Colors.white,fontSize: 12),
      
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide(color: Colors.green, width: 2.0),
      // ),
    ),
  );

  Widget signUpButton(BuildContext context)=> ButtonTheme(
    minWidth: 300,
    height: 50,
    buttonColor: Color.fromRGBO(255, 116, 23, 1),
    child: RaisedButton(
      elevation: 5,
      color: Colors.green,
      // onPressed: validateAndSubmit,
      onPressed: (){
              // validateAndSubmit(context);
             Navigator.of(context).push( MaterialPageRoute(
                builder: (context) => new TimelinePage(title:"Title"),
              ),
            );
            
      },
      child: Text("Sign Up", style: TextStyle(color: Colors.black,fontSize: 12),),
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
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).pop(
                 MaterialPageRoute(builder: (context)=>homePage()));
            },
          ),
          backgroundColor: Color(0x000000)),
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
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2,
                    fontFamily: "Open Sans"
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 200),
                ),
                Text(
                  "           ",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.green,
                    decorationThickness: 5
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              fullName,
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              emailAddress,
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              mobileNumber,
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
                    Icons.help_outline,
                    color: Colors.green,
                  ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  //   borderSide: BorderSide(color: Colors.white, width: 2.0),
                  // ),
                ),
                hint: Text(
                  "Select Your gender",
                  style: TextStyle(color: Colors.white,fontSize: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                    print("$gender");
                  });
                },
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              occupation,
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              institution_or_company,
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              referalCode,
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value;
                        print("$isChecked");
                      });
                    },
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Accept terms and condition",
                      style: TextStyle(color: Colors.grey,fontSize: 12),
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
      ),
    );
  }
}
