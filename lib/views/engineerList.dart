import 'package:adminproto1/models/local.dart';
import 'package:adminproto1/styles/theme/colorStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EngineerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EngineerPage();
  }
}

class _EngineerPage extends State<EngineerPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: Firestore.instance.collection('engineers').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no expense");
              return new ListView(children: getExpenseItems(snapshot, context));
            }),
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    LocalDb.freeEngineers = snapshot.data.documents
        .where((test) => test.data["isAssigned"] == false)
        .length;

    return snapshot.data.documents
        .map((doc) => new Card(
          elevation: 6.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      doc.data["Name"],
                      style: TextStyle(color: Colors.black,fontSize: 16),
                    ),
                    // new Divider(),
                    new Text(doc.data["Designation"].toString(),
                        style: TextStyle(color: Colors.grey,fontSize: 12)),
                  ],
              ),
              Row(children: <Widget>[
                  Icon(
                    Icons.blur_on,
                    color: cs(doc.data["isAssigned"].toString()),
                  ),
              ]),
            ]),
                )

                // onTap: () {
                //   DocumentSnapshot ds = doc;
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => SecondRoute(
                //                 ds: ds,
                //               )));
                // },
                ))
        .toList();
  }

  Color cs(String s) {
    if (s == "false")
      return Colors.green[500];
    else
      return Colors.red[500];
  }
}
