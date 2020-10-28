import 'package:device_info/device_info.dart';
import 'package:doopdashboard/Screens/details_screen.dart';
import 'package:doopdashboard/Screens/home_screen.dart';
import 'package:doopdashboard/Screens/sign_up_screen.dart';
import 'package:doopdashboard/Utils/my_shared_prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  TextEditingController emailC = new TextEditingController(text: '');
  TextEditingController pwC = new TextEditingController(text: '');
  String deviceUid, deviceType;

  bool isObscured = true;

  @override
  void initState() {
    isObscured = true;
    deviceUid = '';
    deviceType = '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfab300),
        centerTitle: true,
        title: Text(
          'Sign In',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Circular',
              fontSize: pHeight * 0.035),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF2e2d2d),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Container(
              width: pWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: pHeight * 0.05,
                      ),
                      Container(
                        width: pWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: emailC,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: pHeight * 0.02),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pHeight * 0.02,
                      ),
                      Container(
                        width: pWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: pwC,
                            obscureText: isObscured,
                            validator: (value) {
                              if (value.length < 6) {
                                return 'Invalid Password';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              suffix: isObscured
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObscured = false;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility,
                                        color: Color(0xFF4E4E4E),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          isObscured = true;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility_off,
                                        color: Color(0xFF4E4E4E),
                                      ),
                                    ),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: pHeight * 0.02),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pHeight * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          if (emailC.text == 'admin@doop.com' &&
                              pwC.text == 'admin123') {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                          }
                        },
                        child: Container(
                          width: pWidth * 0.9,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFfab300),
                                Color(0xFFFFB199),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Circular',
                                    fontSize: pHeight * 0.03),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: pHeight * 0.04,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonalDetails()));
                        },
                        child: Text(
                          'New Sign Up?',
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
