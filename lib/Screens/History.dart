import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ButtonsHistory extends StatefulWidget {
  static final routename = 'history';
  const ButtonsHistory({Key? key}) : super(key: key);

  @override
  State<ButtonsHistory> createState() => _ButtonsHistoryState();
}

class _ButtonsHistoryState extends State<ButtonsHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'History',
              style: TextStyle(color: Colors.black),
            )),
      ),
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var userinfo =
                  json.decode(snapshot.data.getString('userinfo') as String);
              final myListData = [
                userinfo["uid"],
              ];
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UserButtonRequest")
                      .where("uid", isEqualTo: myListData[0])
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snp) {
                    if (snp.hasError) {
                      print(snp);
                      return Center(
                        child: Text("No Data is here"),
                      );
                    } else if (snp.hasData || snp.data != null) {
                      return snp.data!.docs.length < 1
                          ? Center(child: Container(child: Text("No Record")))
                          : ListView.builder(
                              itemCount: snp.data!.docs.length,
                              itemBuilder: (ctx, i) => Container(
                                  child:
                                      ButtonsHistoryBody(snp.data!.docs[i])));
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            }
          }),
    );
  }
}

class ButtonsHistoryBody extends StatefulWidget {
  final comp;
  ButtonsHistoryBody(this.comp);
  @override
  State<ButtonsHistoryBody> createState() => _ButtonsHistoryBodyState();
}

class _ButtonsHistoryBodyState extends State<ButtonsHistoryBody> {
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 20,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          ListTile(
            title: Text(
              'BUTTON TYPE: ${widget.comp.data()['type']}'.toUpperCase(),
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Text(
              'BUTTON PRESSED ON: ${widget.comp.data()['pressedTime'].toDate()}',
              softWrap: true,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
