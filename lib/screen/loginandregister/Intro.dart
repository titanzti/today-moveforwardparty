import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:appmove/screen/loginandregister/Login.dart';
import 'package:appmove/screen/loginandregister/Register.dart';
import 'package:appmove/screen/profile/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatefulWidget {
  final bool islogin;

  const Intro({Key key, this.islogin}) : super(key: key);
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  bool islogin;
  @override
  void initState() {
    super.initState();
    // checklogin();
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
physics: NeverScrollableScrollPhysics(),

        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      // color: Colors.black,
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "images/MFP-Logo-Verticle.png",
                        height: 300,
                        width: 300,
                        fit: (BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF47932),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF47932),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xff0C3455),
                              ),
                              child: Center(
                                child: Text(
                                  "?????????????????????????????????",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 26,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Register()),
                              );
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color(0xff0C3455),
                              ),
                              child: Center(
                                child: Text(
                                  "?????????????????????????????????",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "??????????????????????????????????",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                ),
         
            ],
          ),
        ),
      ),
     
    );
  }
}
