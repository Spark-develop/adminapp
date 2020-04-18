import 'package:adminproto1/styles/theme/colorStyle.dart';
import 'package:adminproto1/styles/widget/btn.dart';
import 'package:adminproto1/styles/widget/no.dart';
import 'package:adminproto1/views/callRequest.dart';
import 'package:adminproto1/views/completeList.dart';
import 'package:adminproto1/views/ongoing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'models/local.dart';
import 'views/engineerList.dart';

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPage();
  }
}

class MainPage extends State<HomePage> {
  DocumentSnapshot ds;

  @override
  Widget build(BuildContext context) {
    // StreamBuilder<QuerySnapshot>(
    //     stream: Firestore.instance.collection('users').snapshots(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (!snapshot.hasData) return new Text("There is no expense");
    //       snapshot.data.documents.map((doc) => doc = ds);
    // });
    return mainscrn();
  }

  Future<void> onStart(DocumentSnapshot dc) async {
    final String uid = dc.reference.parent().parent().documentID.toString();

    await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((string) {
      LocalDb.name = string.data['Name'];
      LocalDb.address = string.data['Address'];
      LocalDb.mobile = string.data['Mobile'].toString();

      // print(string.data['Name']);
      // print(string.data['Address']);
      // print(string.data['Mobile']);
    });
  }

  Widget mainscrn() {
    return Scaffold(
      appBar: AppBar(
        title: Text('connect'),
        backgroundColor: bgColor,
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: StreamBuilder(
          stream: Firestore.instance.collectionGroup('calls').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            else {
              int _request = snapshot.data.documents
                  .where((doc) => doc['isComplete'] == false)
                  .length;
              int _onGoing = snapshot.data.documents
                  .where((doc) => doc['isComplete'] == false)
                  .where((doc) => doc['isAssigned'] == true)
                  .length;
              int _completed = snapshot.data.documents
                  .where((doc) => doc['isComplete'] == true)
                  .length;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CallRequest()));
                      },
                      child: StatsCounter(
                        title: "Request",
                        count: _request,
                        size: 200.0,
                        titleColor: Colors.red,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 3.0,
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ongoing()));
                          },
                          child: StatsCounter(
                            title: "onGoing",
                            count: _onGoing,
                            size: 150.0,
                            titleColor: Colors.lightBlue,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompleteList()));
                          },
                          child: StatsCounter(
                            title: "Completed",
                            count: _completed,
                            size: 150.0,
                            titleColor: Colors.lightGreen,
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 3.0,
                      height: 0,
                    ),
                    StreamBuilder(
                        stream: Firestore.instance
                            .collection('engineers')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          else {
                            int freeEngineer = snapshot.data.documents
                                .where((doc) => doc['isAssigned'] == false)
                                .length;
                            return IndicatorButton(
                              title: "Engineers",
                              indicationCount: freeEngineer,
                              height: 50.0,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EngineerPage()));
                              },
                            );
                          }
                        })
                  ],
                ),
              );
            }
          }),
    );
  }
}

// Future<QuerySnapshot> call() async {
//   var v = await Firestore.instance
//       .collectionGroup('calls')
//       .where('isComplete', isEqualTo: false)
//       .snapshots();
//   return v;
// }
