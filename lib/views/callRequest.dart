import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'detailPage.dart';

class CallRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CallRequest();
  }
}

class _CallRequest extends State<CallRequest> {
  @override
  Widget build(BuildContext context) {
    return Material(child: test(context));
  }

  Widget test(BuildContext context) {
    // var s =  Firestore.instance.collection('calls').where('model',isNull:true).snapshots();
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collectionGroup('calls')
            .where('isComplete', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          // print(snapshot.data.documents);
          // snapshot.data.documents.map((f) => print(f.documentID));
          return Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: new ListView(children: getItems(snapshot, context)),
          );
        });
  }

  getItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data.documents
        .map((doc) => Padding(
          padding: const EdgeInsets.symmetric(horizontal:8.0),
          child: new Card(
            elevation: 6.0,
                  child: InkWell(
                    onTap: () {
                  DocumentSnapshot ds = doc;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondRoute(
                                ds: ds,
                              )));
                },
                                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          doc.data["model"],
                          style: TextStyle(color: Colors.black,fontSize: 16),
                        ),
                        new Divider(),
                        new Text(doc.data["issue"].toString(),
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
                    ),
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
                  ),
        ))
        
        
        
        
        
        
        // new ListTile(
        //       title: new Text(doc.data["model"]),
        //       subtitle: new Text(doc.data["issue"].toString()),
        //       trailing: Icon(
        //         Icons.blur_on,
        //         color: cs(doc.data["isAssigned"].toString()),
        //       ),
        //       onTap: () {
        //         DocumentSnapshot ds = doc;
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => SecondRoute(
        //                       ds: ds,
        //                     )));
        //       },
        //     ))
        .toList();
  }

  Color cs(String s) {
    if (s == "true")
      return Colors.green[500];
    else
      return Colors.red[500];
  }
}
