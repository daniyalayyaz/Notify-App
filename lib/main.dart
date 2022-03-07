import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify_app/Screens/Dashboard.dart';
import 'package:notify_app/Screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/RequestLogin.dart';
import 'Screens/Dashboard.dart';
import 'Screens/Profile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fc = FirebaseMessaging.instance;
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();

    super.initState();
    _fc.subscribeToTopic("Events");
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return MaterialApp(
        home: Scaffold(
          body: AlertDialog(
            content: Text('Something went wrong. Please restart the app.'),
          ),
        ),
      );
    }
    if (!_initialized) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
    return MaterialApp(
        title: 'Notify-App',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
        home: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.data.containsKey("token")
                  ? snapshot.data.getBool("token")
                      ? Home()
                      : LoginScreen()
                  : LoginScreen();
            }),
        routes: {
          LoginScreen.routename: (ctx) => LoginScreen(),
          requestLoginPage.route: (ctx) => requestLoginPage(),
          Home.routeName: (ctx) => Home(),
          UserProfile.routename: (ctx) => UserProfile(),
        });
  }
}
