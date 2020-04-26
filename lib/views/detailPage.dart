import 'package:adminproto1/styles/widget/asset.dart';
import 'package:adminproto1/views/assignEngineerList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatefulWidget {
  DocumentSnapshot ds;

  SecondRoute({Key key, @required this.ds}) : super(key: key);

  @override
  SecR createState() => new SecR();
}

class SecR extends State<SecondRoute> {
  String _mo = "", _is = "", _engineerUid = "";
  bool _isAssigned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: defaultAppBar,
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: FutureBuilder(
          future: onstart(widget.ds),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return mainPage(context, snapshot.data);
            else
              return new CircularProgressIndicator();
          },
        ),
      ),
      backgroundColor: Color(0xFFEEEEEE),
    );
  }

  Widget userDetails(BuildContext context, DocumentSnapshot ds) {
    // setState(() {
    //   _na = LocalDb.name;
    //   _ad = LocalDb.address;
    //   _mo = LocalDb.mobile;
    //   _em = LocalDb.email;
    // });
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "User Information",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Name")],
                  ),
                  Column(
                    children: <Widget>[Text(ds.data['Name'])],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Email")],
                  ),
                  Column(
                    children: <Widget>[Text(ds.data['Email'])],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Mobile No")],
                  ),
                  Column(
                    children: <Widget>[Text(ds.data['Mobile'].toString())],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(ds.data['Address']),
            )
          ],
        ),
      ),
    );
  }

  Widget callInformation(BuildContext context, DocumentSnapshot ds) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Call Information",
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Model No")],
                  ),
                  Column(
                    children: <Widget>[Text(_mo)],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Date")],
                  ),
                  Column(
                    children: <Widget>[Text("29-12-22")],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(_is),
            )
          ],
        ),
      ),
    );
  }

  Widget placeCallSection(BuildContext context, DocumentSnapshot ds) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
          padding: const EdgeInsets.all(10.0), child: assignCallWidget(ds)),
    );
  }

  Widget assignCallWidget(DocumentSnapshot ds) {
    try {
      return StreamBuilder(
          stream: Firestore.instance
              .collection('engineers')
              .where('isAssigned', isEqualTo: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Text("No records");
            else {
              if (!_isAssigned &&
                  !snapshot.data.documents
                      .where((val) => val.documentID == _engineerUid)
                      .isNotEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Assign Call",
                      style: TextStyle(fontSize: 16),
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[Text("Engineers")],
                          ),
                          Column(
                            children: <Widget>[Text("Select a Engineer")],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssignEngineer(
                                        ds: widget.ds,
                                      )));
                        },
                        child: Text("Assign Call"),
                      ),
                    ),
                  ],
                );
              } 
              else 
              {
                if (
                    !snapshot.data.documents
                        .where((val) => val.documentID == _engineerUid)
                        .isNotEmpty)
                         return Text("Error");
                var r = snapshot.data.documents
                    .where((val) => val.documentID == _engineerUid)
                    .single;

                if (r.data.isEmpty) {
                  return Text("No records");
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Assign Call",
                      style: TextStyle(fontSize: 20),
                    ),
                    Divider(
                      color: Colors.black87,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Name"),
                              Text("Desgnation"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(r.data["Name"]),
                              Text(r.data["Designation"]),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 10),
                      child: RaisedButton(
                        color: Colors.redAccent,
                        onPressed: () {
                          CircularProgressIndicator();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssignEngineer(
                                        ds: widget.ds,
                                        engiRef: r,
                                      )));
                          // r.reference.updateData({'isAssigned': false});
                          // ds.reference.updateData(
                          //     {'CallAssignedTo': null, "isAssigned": false});
                          // Navigator.pop(this.context);
                        },
                        child: Text("Change Engineer"),
                      ),
                    ),
                  ],
                );
              }
            }
          });
    } catch (e) {
      print(e);
      return Text("Error");
    }
  }

  Widget mainPage(BuildContext context, DocumentSnapshot ds) {
    // ds.parent().parent().documentID;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        userDetails(context, ds),
        callInformation(context, ds),
        placeCallSection(context, ds),
      ],
    );
  }

  Future<DocumentSnapshot> onstart(DocumentSnapshot dc) async {
    _mo = await dc.data["model"];
    _is = await dc.data["issue"];
    _isAssigned = await dc.data["isAssigned"];
    _engineerUid = await dc.data["CallAssignedTo"];
    if (_mo == null) _mo = "null";
    if (_is == null) _is = "null";
    final String uid = dc.reference.parent().parent().documentID.toString();
    return await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((string) {
      return string;
    });
  }
}
