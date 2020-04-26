import 'package:adminproto1/models/local.dart';
import 'package:adminproto1/styles/theme/colorStyle.dart';
import 'package:adminproto1/styles/widget/asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignEngineer extends StatefulWidget {
  DocumentSnapshot ds;
  DocumentSnapshot engiRef;
  AssignEngineer({Key key, @required this.ds, this.engiRef}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AssignEngineer();
  }
}

class _AssignEngineer extends State<AssignEngineer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: defaultAppBar,
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('engineers')
                .where('isAssigned', isEqualTo: false)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return new Text("There is no calls");
              return new ListView(children: getCallItems(snapshot, context));
            }),
      ),
    );
  }

  getCallItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    LocalDb.freeEngineers = snapshot.data.documents
        .where((test) => test.data["isAssigned"] == false)
        .length;

    return snapshot.data.documents
        .map((doc) => new ListTile(
              title: new Text(
                doc.data["Name"],
                style: TextStyle(color: Colors.white),
              ),
              subtitle: new Text(doc.data["Designation"].toString(),
                  style: TextStyle(color: Colors.grey)),
              trailing: Icon(
                Icons.blur_on,
                color: cs(doc.data["isAssigned"].toString()),
              ),
              onTap: () {
                if (widget.engiRef != null) {
                  widget.engiRef.reference.updateData({'isAssigned': false});
                  widget.ds.reference.updateData(
                      {'CallAssignedTo': null, "isAssigned": false});
                }
                widget.ds.reference.updateData(
                    {"isAssigned": true, "CallAssignedTo": doc.documentID});
                doc.reference.updateData({'isAssigned': true});
                widget.ds.reference.collection('calls');
                int count = 0;
                popUntil(context, (Route) {
                  return count++ == 3;
                });
              },
            ))
        .toList();
  }

  static void popUntil(BuildContext context, RoutePredicate predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  Color cs(String s) {
    if (s == "false")
      return Colors.green[500];
    else
      return Colors.red[500];
  }
}
