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
    final prefs = await SharedPreferences.getInstance();
    final userinfo = json.decode(prefs.getString('userinfo') as String);
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
            label: 'OK', textColor: Colors.greenAccent, onPressed: () {}),
        backgroundColor: Colors.teal,
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
    _controller = VideoPlayerController.asset('assets/Demo.mp4');
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
              backgroundColor: Colors.teal,
              title: FittedBox(fit: BoxFit.fitWidth, child: Text('Home')),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
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
                    color: Colors.white,
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            const Color(0xFFB9F6CA),
                            const Color(0xFFE0F2F1)
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            color: Colors.teal,
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
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.speaker_phone_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  FittedBox(
                                    child: Text(
                                      'Important News jd dkkd dkkd dkdkd dkdk',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
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
                                          margin: EdgeInsets.only(bottom: 2),
                                          child: FutureBuilder<bool>(
                                            future: started(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<bool> snapshot) {
                                              if (snapshot.data == true) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 2),
                                                  height: 160,
                                                  width: 300,
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
                                                      color: Colors.teal),
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
                                  margin: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
                                    child: Image.network(
                                      urls[1],
                                      fit: BoxFit.fitHeight,
                                      width: 100,
                                      height: 240,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
                                    child: Image.network(
                                      urls[2],
                                      fit: BoxFit.fitHeight,
                                      width: 100,
                                      height: 240,
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                    ),
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
                          Expanded(
                            child: Card(
                              color: Colors.teal,
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
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Press Button to raise Alarm!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
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
                                                1.42,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.greenAccent)),
                                              onPressed: () =>
                                                  {alertme("button-one")},
                                              child: Text(buttonLabels[0],
                                                  style: TextStyle(
                                                      color: Colors.teal[900],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.42,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.greenAccent)),
                                              onPressed: () =>
                                                  {alertme("button-two")},
                                              child: Text(buttonLabels[1],
                                                  style: TextStyle(
                                                      color: Colors.teal[900],
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.42,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          20),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.greenAccent)),
                                              onPressed: () =>
                                                  {alertme("button-three")},
                                              child: Text(
                                                buttonLabels[2],
                                                style: TextStyle(
                                                    color: Colors.teal[900],
                                                    fontWeight:
                                                        FontWeight.bold),
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
