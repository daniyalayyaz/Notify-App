import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notify_app/Screens/LoginPage.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:notify_app/Models/NewUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class requestLoginPage extends StatefulWidget {
  static final route = '/RequestLogin';

  @override
  _requestLoginPageState createState() => _requestLoginPageState();
}

class _requestLoginPageState extends State<requestLoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  bool isPhone(String em) {
    String p =
        r'^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  var RegisterationModel = RequestUsers(
      name: '',
      email: '',
      phoneNo: '',
      designation: '',
      age: '',
      owner: '',
      address: '',
      fname: '',
      fphoneNo: '',
      uid: '');
  var initials = {
    'name': '',
    'email': '',
    'phoneNo': '',
    'designation': '',
    'age': '',
    'owner': '',
    'address': '',
    'fname': '',
    'fphoneNo': '',
    'uid': ''
  };
  void saveform() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await FirebaseFirestore.instance.collection('UserRequest').add({
          "Name": RegisterationModel.name,
          "Phoneno": RegisterationModel.phoneNo,
          "address": RegisterationModel.address,
          "fPhonenumber": RegisterationModel.fphoneNo,
          "fName": RegisterationModel.fname,
          "designation": RegisterationModel.designation,
          "age": RegisterationModel.age,
          "owner": RegisterationModel.owner,
          "status": "Pending",
          "email": RegisterationModel.email
        });
        _formKey.currentState!.reset();
        FocusScope.of(context).unfocus();
      } catch (e) {
        print(e);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Details Sent!'),
          action: SnackBarAction(
              label: 'OK', textColor: Colors.greenAccent, onPressed: () {}),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            padding: EdgeInsets.only(left: 20, top: 40),
                            child: Text(
                              "Request Credentials,",
                              style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).padding.top) *
                                      0.060,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 20, bottom: 20, top: 10),
                            child: Text(
                              "Once Admin approve your request, you will get your\ncredentials via Email you provided.",
                              style: TextStyle(
                                  fontSize: (MediaQuery.of(context).size.width -
                                          MediaQuery.of(context).padding.top) *
                                      0.040,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                              textAlign: TextAlign.start,
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
                              vertical: 10.0, horizontal: 20.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['name'] as String,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Your Full Name',
                                    border: InputBorder.none,
                                    hintText: 'Adam Hunt',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required and cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.name = value!;
                                  },
                                  keyboardType: TextInputType.text,
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
                                  Icons.email,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              new Expanded(
                                child: TextFormField(
                                  initialValue: initials['email'] as String,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Your Email',
                                    border: InputBorder.none,
                                    hintText: 'john@email.com',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Invalid email!';
                                    } else if (!isEmail(value)) {
                                      return 'Please enter valid Email.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.email = value!;
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
                                  Icons.phone,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['phoneNo'] as String,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Your Phone Number',
                                    border: InputBorder.none,
                                    hintText: '030xxxxxxxx',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Phone Number is not valid!';
                                    } else if (!isPhone(value)) {
                                      return 'Please enter valid Phone.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.phoneNo = value!;
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
                                  Icons.work_rounded,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue:
                                      initials['designation'] as String,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Job Designation',
                                    border: InputBorder.none,
                                    hintText: 'Associate Marketing Manager',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.designation = value!;
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
                                  Icons.calendar_today_rounded,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['age'] as String,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Your Age',
                                    border: InputBorder.none,
                                    hintText: '22',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.age = value!;
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
                                  Icons.house_rounded,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['owner'] as String,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText:
                                        'Owner/Related Family Member Name',
                                    border: InputBorder.none,
                                    hintText: 'John Smith',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.owner = value!;
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
                                  Icons.pin_drop_rounded,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['address'] as String,
                                  keyboardType: TextInputType.streetAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Enter Your Address',
                                    border: InputBorder.none,
                                    hintText:
                                        '455 Maple St, Brooklyn, NY 11225',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.address = value!;
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
                                  Icons.family_restroom,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['fname'] as String,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: 'Other Family Member Name',
                                    border: InputBorder.none,
                                    hintText: 'William Dennis',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.fname = value!;
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
                                  Icons.phone_in_talk_rounded,
                                  color: Colors.teal,
                                ),
                              ),
                              Container(
                                height: 30.0,
                                width: 1.0,
                                color: Colors.grey.withOpacity(0.5),
                                margin: const EdgeInsets.only(
                                    left: 00.0, right: 10.0),
                              ),
                              Expanded(
                                child: TextFormField(
                                  initialValue: initials['fphoneNo'] as String,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'Family Member Phone Number',
                                    border: InputBorder.none,
                                    hintText: '030xxxxxxxx',
                                    hintStyle: TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be left empty!';
                                    }
                                  },
                                  onSaved: (value) {
                                    RegisterationModel.fphoneNo = value!;
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 20.0),
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                                vertical: 25,
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        MediaQuery.of(context)
                                                            .padding
                                                            .top) *
                                            0.25),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.greenAccent), // <-- Button color
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>((states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.greenAccent[
                                            100]; // <-- Splash color
                                    }),
                                  ),
                                  child: Text(
                                    "Request Credentials",
                                    style:
                                        TextStyle(color: Colors.teal.shade800),
                                  ),
                                  onPressed: saveform,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          //padding: EdgeInsets.all(20),
                          margin: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  child: Text(
                                "You already have an account?",
                                style: TextStyle(color: Colors.teal[800]),
                              )),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff8d43d6)),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          duration: Duration(milliseconds: 700),
                                          type: PageTransitionType
                                              .leftToRightWithFade,
                                          child: LoginScreen()));
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold),
                                ),
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
        ),
      ),
    );
  }
}
