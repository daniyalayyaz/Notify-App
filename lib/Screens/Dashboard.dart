import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marquee/marquee.dart';
import 'package:notify_app/Screens/LoginPage.dart';
import 'package:notify_app/Screens/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:page_transition/page_transition.dart';

class Home extends StatefulWidget {
  static final routeName = "home";

  static List<IconData> navigatorsIcon = [
    Icons.desktop_mac_rounded,
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var buttonLabels;
  List<String> urls = [];
  bool _isInit = true;
  bool _isLoading = true;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('utility');

  void alertme(String collect) async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
          'Are you sure you want to send a Request?',
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
          ),
          ElevatedButton(
            child: Text('Yes'),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              final userinfo =
                  json.decode(prefs.getString('userinfo') as String);
              await FirebaseFirestore.instance.collection(collect).add({
                "name": userinfo["name"],
                "phoneNo": userinfo["phoneNo"],
                "address": userinfo["address"],
                "fphoneNo": userinfo["fphoneNo"],
                "fname": userinfo["fname"],
                "designation": userinfo["designation"],
                "age": userinfo["age"],
                "pressedTime": FieldValue.serverTimestamp(),
                "type": collect,
                "uid": userinfo["uid"],
                "owner": userinfo["owner"],
                "email": userinfo["email"]
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Your Request is sent"),
                  action: SnackBarAction(
                      label: 'OK',
                      textColor: Colors.greenAccent,
                      onPressed: () {}),
                  backgroundColor: Colors.teal,
                ),
              );
              Navigator.of(ctx).pop(true);
            },
          ),
        ],
      ),
    );
  }

  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      _collectionRef.doc('Button').snapshots().listen((snap) {
        buttonLabels = [
          (snap.data() as Map)["btn1"],
          (snap.data() as Map)["btn2"],
          (snap.data() as Map)["btn3"]
        ];
        setState(() {
          _isLoading = false;
        });
      });
      _collectionRef.doc('Slider').snapshots().listen((snap) {
        urls = [
          (snap.data() as Map)["image1"],
          (snap.data() as Map)["image2"],
          (snap.data() as Map)["image3"],
          (snap.data() as Map)["image4"]
        ];
        print(buttonLabels);
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  late VideoPlayerController _controller;
  bool startedPlaying = false;
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video-demo.mp4');
    _controller.addListener(() {
      if (startedPlaying && !_controller.value.isPlaying) {}
    });
    _controller.setLooping(true);
  }

  Future<bool> started() async {
    await _controller.initialize();
    await _controller.play();
    startedPlaying = true;
    return true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var prefs;

  final List<String> navigators = [
    "View History",
  ];

  @override
  Widget build(BuildContext context) {
    print(urls[0].toString());
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Home',
                    style: TextStyle(color: Colors.black),
                  )),
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
                // ElevatedButton(
                //   onPressed: () => {},
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all(Colors.greenAccent),
                //   ),
                //   child: FittedBox(
                //       fit: BoxFit.cover,
                //       child: Text(
                //         'Logout',
                //         style: TextStyle(
                //             color: Colors.teal[900],
                //             fontWeight: FontWeight.bold),
                //       )),
                // ),
              ],
            ),
            // drawer: Drawner(navigators: navigators),
            body: LayoutBuilder(builder: (ctx, constraints) {
              return Center(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.important_devices,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          ' Status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FittedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Attention!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Press Button only when it is important.',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Center(
                              child: Text("News & Feeds",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            height: 150,
                            child: Flexible(
                              flex: 1,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Center(
                                        child: Column(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            // margin: EdgeInsets.only(bottom: 2),
                                            child: FutureBuilder<bool>(
                                              future: started(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<bool>
                                                      snapshot) {
                                                if (snapshot.data == true) {
                                                  return Container(
                                                    // margin: EdgeInsets.only(
                                                    //     bottom: 2),
                                                    height: 100,
                                                    width: 240,
                                                    child: AspectRatio(
                                                      aspectRatio: _controller
                                                          .value.aspectRatio,
                                                      child: Container(
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: VideoPlayer(
                                                                  _controller))),
                                                    ),
                                                  );
                                                } else {
                                                  return const Text(
                                                    'Waiting for Video to load...',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        urls[1],
                                        fit: BoxFit.fitHeight,
                                        width: 100,
                                        height: 250,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        urls[2],
                                        fit: BoxFit.fitHeight,
                                        width: 100,
                                        height: 250,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        urls[0],
                                        width: 100,
                                        fit: BoxFit.fitHeight,
                                        height: 250,
                                      ),
                                    ),
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.all(6.0),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(urls[0].toString()),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.all(6.0),
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(8.0),
                                  //     image: DecorationImage(
                                  //       image: NetworkImage(urls[0].toString()),
                                  //       fit: BoxFit.cover,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Card(
                              color: Colors.grey[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.speaker_phone_rounded,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            'Press any of these buttons!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black)),
                                              onPressed: () =>
                                                  {alertme("button-one")},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                  Text('  ' + buttonLabels[0],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black)),
                                              onPressed: () =>
                                                  {alertme("button-two")},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                  Text('  ' + buttonLabels[1],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.40,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.black)),
                                              onPressed: () =>
                                                  {alertme("button-three")},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    '  ' + buttonLabels[2],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ], //<Widget>[]
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ), //Column
                    )
                    //Padding
                    ), //Container
              );
            }) //Center
            ); //Scaffold
  }
}
