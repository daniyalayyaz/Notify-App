import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:notify_app/Screens/E-Reciept.dart';
import 'package:notify_app/Screens/LoginPage.dart';
import 'package:notify_app/Screens/Profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Grocery extends StatelessWidget {
  const Grocery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List GroceryOrders = [
      {
        'DateTime': 'Dec 22, 2024 - 10:00 AM',
        'Name': 'Muhammad Amir',
        'Address': '667-B, Canal View Lahore',
        'Status': 'Processing'
      },
      // {
      //   'DateTime': 'Dec 08, 2024 - 15:00 PM',
      //   'Name': 'Muhammad Amir',
      //   'Address': '667-B, Canal View Lahore',
      //   'Status': 'Delivered'
      // }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/Images/Invoseg.jpg'),
            height: 50,
            width: 50,
          ),
        ),
        title: Text(
          'Grocery',
          style: TextStyle(
              color: Color(0xff212121),
              fontWeight: FontWeight.w700,
              fontSize: 24),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 700),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: UserProfile()));
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
            onPressed: () async {
              var c = await SharedPreferences.getInstance();
              c.clear();
              Navigator.push(
                  context,
                  PageTransition(
                      duration: Duration(milliseconds: 700),
                      type: PageTransitionType.rightToLeftWithFade,
                      child: LoginScreen()));
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var userinfo =
                  json.decode(snapshot.data.getString('userinfo') as String);

              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 1.2,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: GroceryOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          color: Colors.white,
                          shadowColor: Color(0xffBDBDBD),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      GroceryOrders[index]['DateTime'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Badge(
                                        toAnimate: false,
                                        shape: BadgeShape.square,
                                        badgeColor: GroceryOrders[index]
                                                    ['Status'] ==
                                                'Delivered'
                                            ? Colors.green
                                            : Colors.blueGrey,
                                        borderRadius: BorderRadius.circular(8),
                                        badgeContent: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Text(
                                            GroceryOrders[index]['Status'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    userinfo['name'],
                                    style: TextStyle(
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userinfo['address'],
                                      style: TextStyle(
                                          color: Color(0xff757575),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (GroceryOrders[index]['Status'] ==
                                        'Processing')
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: ElevatedButton(
                                            child: Text('Edit Order',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black)),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: const Radius
                                                                .circular(25.0),
                                                            topRight:
                                                                const Radius
                                                                        .circular(
                                                                    25.0)),
                                                  ),
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: const Radius
                                                                      .circular(
                                                                  25.0),
                                                              topRight: const Radius
                                                                      .circular(
                                                                  25.0))),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              2.4,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        20),
                                                            child: Text(
                                                              'Edit Order',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffF75555),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 24),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16),
                                                            child: Divider(
                                                              thickness: 1,
                                                              color: Color(
                                                                  0xffEEEEEE),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                              'Are you sure you want to send request for edit your order?',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff212121),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: 24),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        10),
                                                            child: Text(
                                                              'You can request for edit your order within 7 minutes after the E-Reciept generated.',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xff424242),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2.4,
                                                                    child:
                                                                        ElevatedButton(
                                                                      child: Text(
                                                                          'Cancel',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.black)),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      style: ButtonStyle(
                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                          )),
                                                                          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 216, 225, 235)),
                                                                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20))),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        2.4,
                                                                    child:
                                                                        ElevatedButton(
                                                                      child: Text(
                                                                          'Yes, Send Request',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: Colors.white)),
                                                                      onPressed:
                                                                          () {},
                                                                      style: ButtonStyle(
                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(100),
                                                                            side:
                                                                                BorderSide(color: Colors.black, width: 2.0),
                                                                          )),
                                                                          backgroundColor: MaterialStateProperty.all(Colors.black),
                                                                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20))),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  side: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                )),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white),
                                                padding:
                                                    MaterialStateProperty.all(
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20))),
                                          ),
                                        ),
                                      ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: SizedBox(
                                        width: GroceryOrders[index]['Status'] ==
                                                'Delivered'
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.7,
                                        child: ElevatedButton(
                                          child: Text('View E-Reciept',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white)),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                ViewEReciept.routename);
                                          },
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                side: BorderSide(
                                                    color: Colors.black,
                                                    width: 2.0),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.black),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20))),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
          }),
    );
  }
}
