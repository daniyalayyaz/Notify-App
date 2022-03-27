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

class Newsandfeeds extends StatefulWidget {
  static final routeName = "Menu2";

  static List<IconData> navigatorsIcon = [
    Icons.desktop_mac_rounded,
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Newsandfeeds> {
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
  int _current = 0;
  final CarouselController _carouselcontroller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'News & Feeds',
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
                  child: Column(children: <Widget>[
                    Container(
                      color: Colors.grey[200],
                      height: 30,
                      child: Marquee(
                        text: 'Security Notify App',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: CarouselSlider(
                            carouselController: _carouselcontroller,

                            items: urls
                                .map((e) => Container(
                                      margin: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        image: DecorationImage(
                                          image: NetworkImage(e.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            //Slider Container properties
                            options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * .68,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                aspectRatio: 30 / 46,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: urls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _carouselcontroller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ]),
                  //<Widget>[]
                ), //Column
              )
                  //Padding
                  //Container
                  );
            }) //Center
            ); //Scaffold
  }
}
