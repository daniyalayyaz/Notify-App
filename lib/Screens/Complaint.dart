import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Complainform extends StatefulWidget {
  const Complainform({Key? key}) : super(key: key);
  static final routename = 'Complaint';

  @override
  State<Complainform> createState() => _ComplainformState();
}

class _ComplainformState extends State<Complainform> {
  var name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 70,
        foregroundColor: Color(0xff212121),
        title: Text(
          'Submit Complaints',
          style: TextStyle(
              color: Color(0xff212121),
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Icon(
                      Icons.feedback_outlined,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: 10.0,
                    width: 1.0,
                    color: Colors.grey.withOpacity(0.5),
                    margin: const EdgeInsets.only(left: 00.0, right: 10.0),
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
                        labelText: 'Enter Complaint',
                        border: InputBorder.none,
                        hintText: 'Enter your Complaint',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Complain required!';
                        }
                      },
                      onSaved: (value) {},
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
                    child: Text('Submit',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                    onPressed: () {},
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        )),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
