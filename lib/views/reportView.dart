import 'package:adminproto1/main.dart';
import 'package:adminproto1/styles/widget/asset.dart';
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
    // return MaterialApp(home: Scaffold(appBar: AppBar(), body: test(context)));
    return Scaffold(
        appBar: defaultAppBar,
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: test(context),
        ));
  }

  Widget test(BuildContext context) {
    Stream st;
    // var s =  Firestore.instance.collection('calls').where('model',isNull:true).snapshots();
    if (_shorting == "ALL") {
      st = Firestore.instance
          .collectionGroup('calls')
          .where('Date', isGreaterThanOrEqualTo: _startDate)
          .where('Date', isLessThanOrEqualTo: _endDate)
          .where('isComplete', isEqualTo: true)
          .snapshots();
    } else {
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
                elevation: 12.0,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Select Shorting"),
                        DropdownButton(
                          items: <DropdownMenuItem>[
                            DropdownMenuItem(
                              child: Text("ALL"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Monitor"),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Text("MotherBoard"),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Text("Router"),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Text("Printer"),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Text("Tablets"),
                              value: 5,
                            ),
                          ],
                          value: _dropdownValue,
                          onChanged: (value) {
                            setState(() {
                              _dropdownValue = value;
                            });
                            print(value);
                          },
                        ),
                        Text(_count.toString()),
                      ],
                    ),
                    RaisedButton(
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
                                          maximumYear: DateTime.now().year,
                                          minimumYear: 2019,
                                          onDateTimeChanged: (val) {
                                            _startDate = val;
                                          }),
                                    ),
                                    Text(
                                      "To",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.lightBlueAccent),
                                    ),
                                    Expanded(
                                      child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          maximumYear: DateTime.now().year,
                                          minimumYear: 2019,
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
                                            _shorting = "ALL";
                                          if (_dropdownValue == 1)
                                            _shorting = "Monitor";
                                          if (_dropdownValue == 2)
                                            _shorting = "MotherBoard";
                                          if (_dropdownValue == 3)
                                            _shorting = "Router";
                                          if (_dropdownValue == 4)
                                            _shorting = "Printer";
                                          if (_dropdownValue == 5)
                                            _shorting = "Tablets";
                                        });
                                        Navigator.pop(this.context);
                                      },
                                    )
                                  ],
                                ),
                              ));
                            });
                      },
                      child: Text("Select Date"),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height*2/3,
            //   child:

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
