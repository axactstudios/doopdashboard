import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as p;

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PersonalDetails extends StatefulWidget {
  String college, course, year;
  PersonalDetails({this.college, this.year, this.course});

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  FirebaseAuth mAuth = FirebaseAuth.instance;
  String deviceUid, deviceType;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController fName = new TextEditingController(text: '');
  TextEditingController lName = new TextEditingController(text: '');
  TextEditingController emailC = new TextEditingController(text: '');
  TextEditingController pwC = new TextEditingController(text: '');
  TextEditingController age = new TextEditingController(text: '');
  TextEditingController bDate = new TextEditingController(text: '');
  TextEditingController pName = new TextEditingController(text: '');
  TextEditingController address = new TextEditingController(text: '');
  TextEditingController mCondition = new TextEditingController(text: '');
  TextEditingController instruction = new TextEditingController(text: '');
  bool isObscured = true;

  @override
  void initState() {
    isObscured = true;
    deviceUid = '';
    deviceType = '';
  }

  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfab300),
        centerTitle: true,
        title: Text(
          'Sign Up',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Circular',
              fontSize: pHeight * 0.035),
        ),
      ),
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF2e2d2d),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: pWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      child: Stack(children: [
                        Center(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          height: 100,
                          width: 100,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              url == null
                                  ? 'https://firebasestorage.googleapis.com/v0/b/doopdashboard.appspot.com/o/profilePictures%2Ft4Bp9TP8STfPpzFSbFJOyUl7cl53?alt=media&token=541b7c50-bf36-4241-9cba-9eba01b779d3'
                                  : url,
                            ),
                          ),
                        )),
                        InkWell(
                          onTap: () async {
                            filePicker(context, this, _scaffoldKey);
                          },
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Colors.black),
                                child: Icon(
                                  Icons.upload_sharp,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: pHeight * 0.05,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: pWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: fName,
                            validator: (value) {
                              if (value.length == 0) {
                                return 'Invalid First Name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
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
                        width: pWidth * 0.1,
                      ),
                      Container(
                        width: pWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: lName,
                            validator: (value) {
                              if (value.length == 0) {
                                return 'Invalid Last Name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: pHeight * 0.02),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        controller: emailC,
                        // validator: (value) {
                        //   if (!validator.email(value)) {
                        //     return 'Invalid Email';
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
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
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: pHeight * 0.02,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: pWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: age,
                            validator: (value) {
                              if (value.length == 0) {
                                return 'Invalid First Name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Age',
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
                        width: pWidth * 0.1,
                      ),
                      Container(
                        width: pWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFE9E9E9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            controller: bDate,
                            validator: (value) {
                              if (value.length == 0) {
                                return 'Invalid Last Name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Birth Date',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  fontSize: pHeight * 0.02),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                        controller: pName,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Invalid First Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Parent\'s Name',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
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
                        controller: address,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Invalid First Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
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
                        minLines: 5,
                        maxLines: 10,
                        controller: mCondition,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Invalid First Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Any medical conditions?',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
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
                        minLines: 5,
                        maxLines: 10,
                        controller: instruction,
                        validator: (value) {
                          if (value.length == 0) {
                            return 'Invalid First Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText:
                              'Anything you want instructor to be extra careful about?',
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(
                              fontFamily: 'Circular', fontSize: pHeight * 0.02),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: pHeight * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        // signUpWithEmailAndPassword();
                        _createUser(emailC.text, pwC.text, context);
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
                            'Sign Up',
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
                    height: pHeight * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceUid = iosDeviceInfo.identifierForVendor; // unique ID on iOS
      deviceType = 'iPhone';
      setState(() {
        print('Device uid found');
      });
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceUid = androidDeviceInfo.androidId; // unique ID on Android
      deviceType = 'Android';
      setState(() {
        print('Device uid found');
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  _createUser(String email, String pw, context) {
    _auth
        .createUserWithEmailAndPassword(email: email, password: pw)
        .then((authResult) async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.sendEmailVerification();
      Fluttertoast.showToast(
          msg: 'Verification link has been sent to your email address!',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);

      final databaseReference = Firestore.instance;
      await databaseReference.collection('Users').add({
        'fname': fName.text,
        'id': user.uid,
        'mail': emailC.text,
        'pUrl': url,
        'lname': lName.text,
        'age': age.text,
        'bDate': bDate.text,
        'pName': pName.text,
        'address': address.text,
        'mCondition': mCondition.text,
        'instruction': instruction.text
      });
      setState(() {
        // n = name.text;
      });
      fName.clear();
      lName.clear();
      emailC.clear();
      pwC.clear();
      // R.Router.navigator.pushNamed(R.Router.setLocationScreen);
//      FirebaseAuth.instance.signOut();
    }).catchError((err) {
      print(err);
      if (err == 'ERROR_EMAIL_ALREADY_IN_USE') {
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
      if (err == 'ERROR_MISSING_EMAIL') {
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
      if (err == 'ERROR_WEAK_PASSWORD') {
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
      if (err == 'ERROR_INVALID_EMAIL') {
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
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

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
