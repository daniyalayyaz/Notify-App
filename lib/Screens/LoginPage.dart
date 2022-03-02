import 'package:flutter/material.dart';
import 'package:notify_app/Screens/Dashboard.dart';
import 'package:notify_app/Screens/RequestLogin.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "WELCOME TO NOTIFY",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: (MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).padding.top) *
                                      0.060,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.teal,
                                  ),
                                ),
                                Container(
                                  height: 10.0,
                                  width: 1.0,
                                  color: Colors.grey.withOpacity(0.5),
                                  margin: const EdgeInsets.only(
                                      left: 00.0, right: 10.0),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: InputBorder.none,
                                      hintText: 'Enter your Email Address',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !value.contains('@')) {
                                        return 'Invalid email!';
                                      }
                                    },
                                    onSaved: (value) {},
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: Colors.teal,
                                  ),
                                ),
                                Container(
                                  height: 10.0,
                                  width: 1.0,
                                  color: Colors.grey.withOpacity(0.5),
                                  margin: const EdgeInsets.only(
                                      left: 00.0, right: 10.0),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      border: InputBorder.none,
                                      hintText: 'Enter your Password here',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Password is too short!';
                                      }
                                    },
                                    onSaved: (value) {},
                                    obscureText: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 10),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      )),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width -
                                                          MediaQuery.of(context)
                                                              .padding
                                                              .top) *
                                              0.08),
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors
                                              .greenAccent), // <-- Button color
                                      overlayColor: MaterialStateProperty
                                          .resolveWith<Color?>((states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Colors.greenAccent[
                                              100]; // <-- Splash color
                                      }),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0),
                                            child: Text(
                                              "Login",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.teal[800],
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                          Transform.translate(
                                            offset: Offset(15.0, 0.0),
                                            child: Container(
                                              // padding: const EdgeInsets.on(1.0),
                                              child: TextButton(
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.teal[800],
                                                ),
                                                onPressed: () => {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  700),
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child: Home()))
                                                  // Navigator.of(context)
                                                  //     .pushNamed(Home.routeName)
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    onPressed: () => {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5.0),
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        child: FittedBox(
                                            child: Text(
                                                "Don\'t have an account?"))),
                                    Container(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle:
                                              const TextStyle(fontSize: 10),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: Duration(
                                                      milliseconds: 700),
                                                  type: PageTransitionType
                                                      .rightToLeftWithFade,
                                                  child: requestLoginPage()));
                                        },
                                        child: const Text(
                                          'Request Login Credentials.',
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
