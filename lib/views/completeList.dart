import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';

class CompleteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompleteList();
  }
}

class _CompleteList extends State<CompleteList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(child: test(context));
  }

  Widget test(BuildContext context) {
    // var s =  Firestore.instance.collection('calls').where('model',isNull:true).snapshots();
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collectionGroup('calls')
            .where('isComplete', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          // print(snapshot.data.documents);
          // snapshot.data.documents.map((f) => print(f.documentID));
          return new ListView(children: getExpenseItems(snapshot, context));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
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
                          doc.data["model"],
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        // new Divider(),
                        new Text(doc.data["issue"].toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
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
    if (s == "true")
      return Colors.green[500];
    else
      return Colors.red[500];
  }
}
