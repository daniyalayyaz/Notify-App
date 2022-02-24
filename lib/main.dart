import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      print(e);
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      print(_error);
      return CircularProgressIndicator();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    // return MultiProvider(
    //     providers: [
    //       // ChangeNotifierProvider(
    //       //   create: (ctx) => Auth(),
    //       // ),
    //     ],

    return MaterialApp(
        title: 'Police Sfs',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Lato',
        ),
        // home: Constants.prefs.getBool('login') == true
        //     ? ProductsOverviewScreen()
        //     : AuthScreen(),
        home: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('testing')
                .doc("timestamp")
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snp) {
              if (snp.hasData) {
                print(((snp.data!.data() as Map)["Date"].toString()));
              }
              return CircularProgressIndicator();
            }));
  }
}
