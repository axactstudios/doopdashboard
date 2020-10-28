import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doopdashboard/volunteer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Volunteer> volunteers = new List<Volunteer>();
  @override
  Widget build(BuildContext context) {
    final pHeight = MediaQuery.of(context).size.height;
    final pWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFfab300),
        centerTitle: true,
        title: Text(
          'Dashboard',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Circular',
              fontSize: pHeight * 0.035),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFF2e2d2d),
      body: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection('Users').snapshots(),
              builder: (BuildContext context, snap) {
                volunteers.clear();
                var orderID, status;
                if (snap.hasData && !snap.hasError && snap.data != null) {
                  for (int i = 0; i < snap.data.documents.length; i++) {
                    Volunteer v = Volunteer(
                        snap.data.documents[i]['fname'],
                        snap.data.documents[i]['mCondition'],
                        snap.data.documents[i]['age'],
                        snap.data.documents[i]['pName'],
                        snap.data.documents[i]['address'],
                        snap.data.documents[i]['bDate'],
                        snap.data.documents[i]['mail'],
                        snap.data.documents[i]['instructions'],
                        snap.data.documents[i]['lname']);
                    volunteers.add(v);
                  }
                }
                return volunteers.length == 0
                    ? Container()
                    : Container(
                        child: ListView.builder(
                            itemCount: volunteers.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Image.network(
                                          'https://www.pavilionweb.com/wp-content/uploads/2017/03/man-300x300.png',
                                          height: pHeight * 0.16,
                                          width: pHeight * 0.1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${volunteers[i].fname} ${volunteers[i].lname}',
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: pHeight * 0.03),
                                              ),
                                              Text(
                                                volunteers[i].address,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: pHeight * 0.025,
                                                  color: Colors.black
                                                      .withOpacity(0.75),
                                                ),
                                              ),
                                              Text(
                                                volunteers[i].email,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: pHeight * 0.02,
                                                  color: Colors.black
                                                      .withOpacity(0.55),
                                                ),
                                              ),
                                              Text(
                                                'Age: ${volunteers[i].age}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: pHeight * 0.02,
                                                  color: Colors.black
                                                      .withOpacity(0.55),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
              })),
    );
  }
}
