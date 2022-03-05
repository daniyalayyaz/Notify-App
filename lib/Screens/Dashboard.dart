import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marquee/marquee.dart';
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
                  onPressed: () {},
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
                    color: Colors.blueGrey[50],
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: CarouselSlider(
                                  items: urls
                                      .map((e) => Container(
                                            margin: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              image: DecorationImage(
                                                image:
                                                    NetworkImage(e.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  //Slider Container properties
                                  options: CarouselOptions(
                                    height: 180.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        Duration(milliseconds: 800),
                                    viewportFraction: 0.8,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            flex: 2,
                            fit: FlexFit.loose,
                            child: FutureBuilder<bool>(
                              future: started(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<bool> snapshot) {
                                if (snapshot.data == true) {
                                  return Container(
                                    height: 200,
                                    child: AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    ),
                                  );
                                } else {
                                  return const Text(
                                    'Waiting for Video to load...',
                                    style: TextStyle(color: Colors.teal),
                                  );
                                }
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.greenAccent)),
                                        onPressed: () =>
                                            {alertme("button-one")},
                                        child: Text(buttonLabels[0],
                                            style: TextStyle(
                                                color: Colors.teal[900],
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.greenAccent)),
                                        onPressed: () =>
                                            {alertme("button-two")},
                                        child: Text(buttonLabels[1],
                                            style: TextStyle(
                                                color: Colors.teal[900],
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width / 1.42,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.greenAccent)),
                                    onPressed: () => {alertme("button-three")},
                                    child: Text(
                                      buttonLabels[2],
                                      style: TextStyle(
                                          color: Colors.teal[900],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Colors.teal[100],
                            height: 30,
                            child: Marquee(
                              text: 'Security Notify App',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 20.0,
                              velocity: 100.0,
                              pauseAfterRound: Duration(milliseconds: 100),
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
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
