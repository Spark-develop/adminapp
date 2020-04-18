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
        backgroundColor: bgColor,
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
      LocalDb.freeEngineers = snapshot.data.documents.where((test)=>test.data["isAssigned"]==false).length;

    return snapshot.data.documents
        .map((doc) => new ListTile(
              
              title: new Text(doc.data["Name"],style: TextStyle(color: Colors.white),),
              subtitle: new Text(doc.data["Designation"].toString(),style: TextStyle(color: Colors.grey)),
              trailing: Icon(
                Icons.blur_on,
                color: cs(doc.data["isAssigned"].toString()),
              ),
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
