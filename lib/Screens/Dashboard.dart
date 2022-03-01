import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:marquee/marquee.dart';

import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  static final routeName = "home";
  static List<IconData> navigatorsIcon = [
    Icons.desktop_mac_rounded,
  ];

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> urls = [
    "https://www.xavor.com/wp-content/uploads/mobile-app-security-checklist.jpg",
    "https://m.media-amazon.com/images/I/51siyARmfOL._AC_SL1100_.jpg",
    "https://images.unsplash.com/photo-1638913662584-731da41f5a59?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8c2VjdXJpdHl8ZW58MHx8MHx8&w=1000&q=80",
    "https://static1.anpoimages.com/wordpress/wp-content/uploads/2020/07/02/MiSecurity.png",
    "https://media.istockphoto.com/photos/digital-security-concept-picture-id1289956604?b=1&k=20&m=1289956604&s=170667a&w=0&h=fpkFDlqRrw_IzsQpZkuYqfgCUw7VMemUT8IuCH4-e9w="
  ];
  late VideoPlayerController _controller;
  bool startedPlaying = false;
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/bee.mp4');
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: FittedBox(fit: BoxFit.fitWidth, child: Text('Home')),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
              ),
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.teal[900], fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
        // drawer: Drawner(navigators: navigators),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return Center(
            child: Container(
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
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image: NetworkImage(e.toString()),
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
                  FutureBuilder<bool>(
                    future: started(),
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == true) {
                        return Container(
                          height: 200,
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        );
                      } else {
                        return const Text('waiting for video to load');
                      }
                    },
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
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.greenAccent)),
                                onPressed: () => null,
                                child: Text('Office',
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
                              width: MediaQuery.of(context).size.width / 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.greenAccent)),
                                onPressed: () => null,
                                child: Text('Emergency',
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
                          width: MediaQuery.of(context).size.width / 1.42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.greenAccent)),
                            onPressed: () => null,
                            child: Text(
                              'Ambulance',
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
                      text: 'Security notify App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      scrollAxis: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      blankSpace: 20.0,
                      velocity: 100.0,
                      pauseAfterRound: Duration(seconds: 1),
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
