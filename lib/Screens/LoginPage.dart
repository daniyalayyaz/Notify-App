import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notify_app/Screens/Dashboard.dart';
import 'package:notify_app/Screens/RequestLogin.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static final routename = 'login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var logins = {"user": "", "pass": ""};
  final GlobalKey<FormState> _formKey = GlobalKey();
  void login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: logins['user'].toString().trim(),
              password: logins['pass'].toString().trim())
          .then((e) async {
        FirebaseFirestore.instance
            .collection("UserRequest")
            .where("email", isEqualTo: e.user!.email)
            .where("uid", isEqualTo: e.user!.uid)
            .where("status", isEqualTo: "Approve")
            .get()
            .then((main) async {
          if (main.docs.length < 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Your Application is Not Approved yet'),
                action: SnackBarAction(label: 'OK', onPressed: () {}),
                backgroundColor: Colors.teal,
              ),
            );
          } else {
            var info = main.docs[0].data();
            final prefs = await SharedPreferences.getInstance();
            final userinfo = json.encode({
              "name": info["Name"],
              "phoneNo": info["Phoneno"],
              "address": info["address"],
              "fphoneNo": info["fPhonenumber"],
              "fname": info["fName"],
              "designation": info["designation"],
              "age": info["age"],
              "uid": e.user!.uid,
              "owner": info["owner"],
              "email": info["email"]
            });
            await prefs.setString('userinfo', userinfo);
            await prefs.setBool("token", true);

            Navigator.push(
                context,
                PageTransition(
                    duration: Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeftWithFade,
                    child: Tab()));
          }
        });
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            action: SnackBarAction(
                label: 'OK', textColor: Colors.black, onPressed: () {}),
            backgroundColor: Colors.grey[400],
          ),
        );
      });
    }
  }

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
                                "WELCOME TO INVOSEG",
                                style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).padding.top) *
                                      0.070,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
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
                                    color: Colors.black,
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
                                    onSaved: (value) {
                                      logins['user'] = value!;
                                    },
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
                                    color: Colors.black,
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
                                    onSaved: (value) {
                                      logins['pass'] = value!;
                                    },
                                    obscureText: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Container(
                          //   child: TextButton(
                          //     style: TextButton.styleFrom(
                          //       textStyle: const TextStyle(fontSize: 10),
                          //     ),
                          //     onPressed: () {},
                          //     child: const Text(
                          //       'Forgot Password?',
                          //       style: TextStyle(
                          //           color: Colors.black54,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 50,
                              child: Container(
                                child: ElevatedButton(
                                  child: Text('Sign in',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                  onPressed: () {
                                    login();
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      )),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20))),
                                ),
                              ),
                            ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.only(top: 5.0),
                          //   padding:
                          //       const EdgeInsets.only(left: 20.0, right: 20.0),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Container(
                          //               child: FittedBox(
                          //                   child: Text(
                          //                       "Don\'t have an account?"))),
                          //           Container(
                          //             child: TextButton(
                          //               style: TextButton.styleFrom(
                          //                 textStyle:
                          //                     const TextStyle(fontSize: 10),
                          //               ),
                          //               onPressed: () {
                          //                 Navigator.push(
                          //                     context,
                          //                     PageTransition(
                          //                         duration: Duration(
                          //                             milliseconds: 700),
                          //                         type: PageTransitionType
                          //                             .rightToLeftWithFade,
                          //                         child: requestLoginPage()));
                          //               },
                          //               child: const Text(
                          //                 'Request Login Credentials.',
                          //                 style: TextStyle(
                          //                     color: Colors.teal,
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
