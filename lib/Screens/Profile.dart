import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  static final routename = 'userprofile';

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.greenAccent],
                    ),
                  ),
                  child: Column(children: [
                    SizedBox(
                      height: 110.0,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      backgroundImage:
                          AssetImage('assets/Images/profile-Icon-SVG.jpg'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text('Daniyal',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Software Engineer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                      child: Card(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 20.0),
                          child: Container(
                              width: 310.0,
                              //height: 290.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "More Information",
                                        style: TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey[300],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.home,
                                            color: Colors.blueAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Address",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "Johar town",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.date_range_rounded,
                                            color: Colors.greenAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Age",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "22",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Colors.pinkAccent[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Phone",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "03336557811",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.star_purple500_outlined,
                                            color: Colors.blue[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Owner Or Related Family Member",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "Muhammad Ayyaz",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: Colors.lightGreen[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Other Family Member Name",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "Awais Shahbaz",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.phone_in_talk_rounded,
                                            color: Colors.teal[400],
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Other Family Member Phone",
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                "03054055977",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )))),
                ),
              ),
            ],
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 20.0,
              right: 20.0,
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.yellowAccent[400],
                      size: 35,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "daniyalayyaz86@gmail.com",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))),
        ],
      ),
    );
  }
}
