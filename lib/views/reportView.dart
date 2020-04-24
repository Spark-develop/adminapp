import 'package:adminproto1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  String _shorting = "";
  int _count = 0, _dropdownValue = 0;
  DateTime _startDate, _endDate;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(appBar: AppBar(), body: test(context)));
  }

  Widget test(BuildContext context) {
    Stream st;
    // var s =  Firestore.instance.collection('calls').where('model',isNull:true).snapshots();
    if (_shorting != "") {
      st = Firestore.instance
          .collectionGroup('calls')
          .where('Date', isGreaterThanOrEqualTo: _startDate)
          .where('Date', isLessThanOrEqualTo: _endDate)
          .where('isComplete', isEqualTo: true)
          .snapshots();
    } 
    else
     {
      st = Firestore.instance
          .collectionGroup('calls')
          .where('Tag', isEqualTo: _shorting)
          .where('Date', isGreaterThanOrEqualTo: _startDate)
          .where('Date', isLessThanOrEqualTo: _endDate)
          .where('isComplete', isEqualTo: true)
          .snapshots();
    }
    return new StreamBuilder<QuerySnapshot>(
        stream: st,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //  getCount();
          if (!snapshot.hasData) return new Text("There is no expense");
          _count = snapshot.data.documents.length;
          // print(snapshot.data.documents);
          // snapshot.data.documents.map((f) => print(f.documentID));
          return Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Select Shorting"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        items: <DropdownMenuItem>[
                          DropdownMenuItem(
                            child: Text("Monitor"),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text("MotherBoard"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("Router"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Text("Printer"),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Text("Tablets"),
                            value: 4,
                          ),
                        ],
                        value: 0,
                        onChanged: (value) {
                          _dropdownValue = value;
                          print(value);
                        },
                      ),
                    ),
                    Text(_count.toString())
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height*2/3,
            //   child:
            FlatButton(
              onPressed: () {
                return showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Card(
                          child: SizedBox(
                        height: 300,
                        child: Column(
                          children: <Widget>[
                            Text("From",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.lightBlueAccent)),
                            Expanded(
                              child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (val) {
                                    _startDate = val;
                                  }),
                            ),
                            Text(
                              "To",
                              style: TextStyle(
                                  fontSize: 25, color: Colors.lightBlueAccent),
                            ),
                            Expanded(
                              child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  onDateTimeChanged: (val) {
                                    _endDate = val;
                                  }),
                            ),
                            FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                setState(() {
                                  // _count=;
                                  if (_dropdownValue == 0)
                                    _shorting = "Monitor";
                                  if (_dropdownValue == 1)
                                    _shorting = "MotherBoard";
                                  if (_dropdownValue == 2) _shorting = "Router";
                                  if (_dropdownValue == 3)
                                    _shorting = "Printer";
                                  if (_dropdownValue == 4)
                                    _shorting = "Tablets";
                                });
                              },
                            )
                          ],
                        ),
                      ));
                    });
              },
              child: Text("Select Date"),
            ),

            Expanded(
              child: new ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: getItems(snapshot, context)),
            )
            //  ),
          ]);
        });
  }
}

getItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
  return snapshot.data.documents
      .map((doc) => new Card(
          elevation: 6.0,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                          // ds: ds,
                          )));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                        new Divider(),
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
            ),
          )))
      .toList();
}

Color cs(String s) {
  if (s == "true")
    return Colors.green[500];
  else
    return Colors.red[500];
}
