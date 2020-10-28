import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fnameController = new TextEditingController();
  TextEditingController lnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: height / 50),
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: GestureDetector(
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: width / 19,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, height / 7.5, 20, 0),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height / 25),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'JOIN NOW',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(13, height / 25, 13, 10),
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: width / 2.3),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(hintText: 'First Name'),
                                controller: fnameController,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 2.3),
                              child: TextFormField(
                                decoration:
                                    InputDecoration(hintText: 'Last Name'),
                                controller: lnameController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(13, height / 35, 13, 10),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),
                          controller: emailController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(13, height / 35, 13, 10),
                        child: TextFormField(
                          decoration: InputDecoration(hintText: 'Password'),
                          controller: passController,
                          obscureText: true,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _createUser(emailController.text,
                                passController.text, context);
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(13, height / 35, 13, 25),
                          child: Container(
                            height: height / 18,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(23),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  offset: const Offset(0, 1),
                                  blurRadius: 4,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width / 22,
                                  letterSpacing: 1.4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: height / 15),
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Already a Member ? ",
                          style: GoogleFonts.michroma(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: " Login",
                          style: GoogleFonts.michroma(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _createUser(String email, String pw, context) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser;
      user.sendEmailVerification();
      Fluttertoast.showToast(
          msg: 'Verification link has been sent to your email address!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);

      final databaseReference = Firestore.instance;
      await databaseReference.collection('Users').add({
        'Name': '${fnameController.text} ${lnameController.text}',
        'id': user.uid,
        'mail': emailController.text,
        'pUrl': url
      });
      setState(() {
        // n = name.text;
      });
      fnameController.clear();
      lnameController.clear();
      passController.clear();
      emailController.clear();
      // R.Router.navigator.pushNamed(R.Router.setLocationScreen);
//      FirebaseAuth.instance.signOut();

//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//        return new MaterialApp(
//          theme: ThemeData(
//            scaffoldBackgroundColor: Colors.white,
//            primaryColor: Colors.white,
//          ),
//          home: HomeScreen(),
//        );
//      }));
    }).catchError((err) {
      print(err);
      if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('This email is already in use'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err.code == 'ERROR_MISSING_EMAIL') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Please Enter Email'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err.code == 'ERROR_WEAK_PASSWORD') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Password should be of 6 or more characters'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
      if (err.code == 'ERROR_INVALID_EMAIL') {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Enter a valid email.'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    });
    //     : showCupertinoDialog(
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog(
    //       title: Text('Passwords don\'t match!'),
    //       actions: <Widget>[
    //         CupertinoDialogAction(
    //           child: Text('OK'),
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //         )
    //       ],
    //     );
    //   },
    // );
  }

  ProgressDialog pr;

  bool _isLoading = false;

  double _progress = 0;

  String url;

  void _uploadFile(File file, String filename, context, state, key) async {
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: 'gs://doopdashboard.appspot.com/');
    FirebaseUser user = await FirebaseAuth.instance.currentUser;

    StorageReference storageReference;
    storageReference = _storage
        .ref()
        .child("Users/${DateTime.now().millisecondsSinceEpoch}/profileImage");

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      textDirection: TextDirection.ltr,
      isDismissible: false,
    );
    pr.style(
      progressWidget: CircularProgressIndicator(),
      message: 'Uploading photo...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      progressWidgetAlignment: Alignment.center,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    await pr.show();
    uploadTask.events.listen((event) {
      state.setState(() {
        _isLoading = true;
        _progress = (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble()) *
            100;
        print('${_progress.toStringAsFixed(2)}%');
        pr.update(
          progress: double.parse(_progress.toStringAsFixed(2)),
          maxProgress: 100.0,
        );
      });
    }).onError((error) {
      key.currentState.showSnackBar(new SnackBar(
        content: new Text(error.toString()),
        backgroundColor: Colors.red,
      ));
    });

    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());

    Fluttertoast.showToast(
        msg: 'Upload Complete', gravity: ToastGravity.BOTTOM);
    state.setState(() async {
      print("URL is $url");
      await pr.hide();
    });
  }

  File file;

  String fileName = '';

  Future filePicker(BuildContext context, state, key) async {
    try {
      print(1);
      file = await ImagePicker.pickImage(source: ImageSource.gallery);
      print(1);
      state.setState(() {
        fileName = p.basename(file.path);
      });
      print(fileName);
      Fluttertoast.showToast(msg: 'Uploading...', gravity: ToastGravity.BOTTOM);
      state.setState(() {});
      _uploadFile(file, fileName, context, state, key);
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
