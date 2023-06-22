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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image(
            image: AssetImage('assets/Images/Lake-City-Logo.png'),
            height: 60,
            width: 60,
          ),
        ),
        title: Text(
          'History',
          style: TextStyle(
              color: Color(0xff212121),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
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
                              physics: BouncingScrollPhysics(),
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
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.white,
          shadowColor: Color(0xffBDBDBD),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: ListTile(
                tileColor: Colors.white,
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        image: widget.comp.data()['type'] == 'button-one'
                            ? AssetImage('assets/Images/Security.jpg')
                            : widget.comp.data()['type'] == 'button-two'
                                ? AssetImage('assets/Images/Doctor.jpg')
                                : AssetImage('assets/Images/Grocery.avif'))),
                title: Text(
                  widget.comp.data()['type'] == 'button-one'
                      ? 'SECURITY'
                      : widget.comp.data()['type'] == 'button-two'
                          ? 'EMERGENCY'
                          : 'GROCERY',
                  style: TextStyle(
                      color: Color(0xff212121), fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  widget.comp.data()['pressedTime'].toDate().toString(),
                  style: TextStyle(
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                ),
              )),
        ),
      ),
    );
  }
}
