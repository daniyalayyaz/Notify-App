import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FamilyMembers extends StatefulWidget {
  static final routename = 'Family-Members';
  @override
  _FamilyMembersState createState() => _FamilyMembersState();
}

class _FamilyMembersState extends State<FamilyMembers> {
  final _auth = FirebaseAuth.instance;
  var emailaddress;
  var password;
  var name;
  var cpassqord;
  var phonenumber;
  var adminmember;
  var uaddress;
  var uphonenumber;

  var uname;
  var uemailaddress;
  var udesignation;

  submit() async {
    final prefs = await SharedPreferences.getInstance();
    var loignemail = prefs.getString('email').toString();
    var loginpass = prefs.getString('pass').toString();

    try {
      EasyLoading.show(status: 'Loading...');

      try {
        var userrecord = FirebaseFirestore.instance
            .collection("UserRequest")
            .where('ownermail', isEqualTo: _auth.currentUser!.email)
            .get()
            .then((value) async {
          if (value.docs.length >= 4) {
            EasyLoading.showError("Maximum Logins Exceeded!");
          } else {
            FirebaseFirestore.instance
                .collection("UserRequest")
                .where('ownermail', isEqualTo: _auth.currentUser!.email)
                .where("role", isEqualTo: "admin")
                .get()
                .then((res) async {
              setState(() {
                uaddress = res.docs[0]['address'];
                uname = res.docs[0]['Name'];
                // uemailaddress = value.docs[0]['email'];
                uphonenumber = res.docs[0]['fPhonenumber'];
              });
            });

            final newUser = await _auth.createUserWithEmailAndPassword(
                email: emailaddress, password: password);

            final old = await _auth.signInWithEmailAndPassword(
                email: loignemail, password: loginpass);

            if (newUser != null) {
              await FirebaseFirestore.instance.collection('UserRequest').add({
                "ownermail": _auth.currentUser!.email,
                "Name": name,
                "Phoneno": phonenumber,

                "address": uaddress,
                "fPhonenumber": uphonenumber,
                "fName": uname,
                "designation": "job",
                "age": '-',
                "owner": uname,
                "status": "Approve",
                "email": emailaddress,
                "role": "child",
                "uid": newUser.user!.uid,
                // "childemail": emailaddress,
              });
              EasyLoading.showSuccess("Account Create Successfully");
              _formKey.currentState!.reset();
            }
          }
        });
      } catch (e) {
        EasyLoading.showError(e.toString());
        print(e);
      }
    } catch (error) {
      print(error);
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

      EasyLoading.showError(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      print(error);
      EasyLoading.showError(errorMessage);
    }
    // setState(() {
    //   _isLoading = false;
    // });
  }

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
                              child: Column(
                                children: [
                                  Text(
                                    "ADD FAMILY MEMBERS",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize:
                                          (MediaQuery.of(context).size.width -
                                                  MediaQuery.of(context)
                                                      .padding
                                                      .top) *
                                              0.060,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Maximum 8 Inherited Logins Allowed",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontSize:
                                            (MediaQuery.of(context).size.width -
                                                    MediaQuery.of(context)
                                                        .padding
                                                        .top) *
                                                0.040,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
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
                                    onChanged: (val) {
                                      setState(() {
                                        name = val;
                                      });
                                    },
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      labelText: 'Family Member Name',
                                      border: InputBorder.none,
                                      hintText: 'Enter your Family Member Name',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Family Member Name is required!';
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
                                vertical: 20.0, horizontal: 20.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: Icon(
                                    Icons.email,
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
                                    onChanged: (val) {
                                      emailaddress = val;
                                    },
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
                                vertical: 20.0, horizontal: 20.0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 15.0),
                                  child: Icon(
                                    Icons.phone,
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
                                    onChanged: (val) {
                                      phonenumber = val;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Family Member Phone Number',
                                      border: InputBorder.none,
                                      hintText:
                                          'Enter your Family Member Phone Number',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Family Member Phone Number is required!';
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
                                    onChanged: (val) {
                                      setState(() {
                                        password = val;
                                      });
                                    },
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
                                    Icons.lock,
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
                                    onChanged: (val) {
                                      setState(() {
                                        cpassqord = val;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: InputBorder.none,
                                      hintText:
                                          'Enter your Confirm Password here',
                                      hintStyle: TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value.length < 6) {
                                        return 'Confirm Password is too short!';
                                      }
                                    },
                                    onSaved: (value) {},
                                    obscureText: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.1,
                                height: 50,
                                child: Container(
                                  child: ElevatedButton(
                                    child: Text('Add Member',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white)),
                                    onPressed: submit,
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
                              ))
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
