import 'package:appmove/screen/home/HomeScreen.dart';
import 'package:appmove/screen/home/appbar.dart';
import 'package:appmove/screen/loginandregister/Register.dart';
import 'package:appmove/utils/colors.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/widgets/allWidgets.dart';
// import 'package:appmove/ttt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isloading = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _storage = FlutterSecureStorage();
  var tokenvalue;
  var mytoken,  myuid;
  bool iserror = false;
  String _error;
  bool _autoValidate = false;
  bool _isButtonDisabled = false;
  bool _obscureText = true;
  bool _isEnabled = true;

  Future<http.Response> singin(String email, String pass) async {
    print('singin');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final storage = new FlutterSecureStorage();

    var url = "https://today-api.moveforwardparty.org/api/login";
    Map data = {"username": email, "password": pass};
    final headers = {
      "mode": "EMAIL",
      "content-type": "application/json",
    };
    var body = jsonEncode(data);

    var res = await http.post(url, headers: headers, body: body);
    final jsonResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      if (jsonResponse['status'] == 1) {
        print(jsonResponse['message']);
        if (jsonResponse != null) {
          sharedPreferences.setString(
              "token", '${jsonResponse["data"]["token"]}');
               sharedPreferences.setString(
              "myuid", '${jsonResponse["data"]["user"]["id"]}');
          sharedPreferences?.setBool("isLoggedIn", true);
          mytoken = jsonResponse["data"]["token"];
            myuid =  jsonResponse["data"]["user"]["id"];
           print("myuid$myuid");

          if (mytoken != null) {
            _isloading = true;
          } else if (mytoken == null) {
            iserror = true;
          }
        
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => Appbar(
                        istoken: mytoken,
                      )),
              (Route<dynamic> route) => false);
          
           
        } else {
          setState(() {
            _isloading = false;
          });
        }
      }
    }
    if (res.statusCode == 400) {
      if (jsonResponse['status'] == 0) {
        print(jsonResponse['message']);
        setState(() {
          _isloading = false;

          iserror = true;
        });
      }
    }
  }

  @override
  void initState() {
    checkInternetConnectivity().then((value) =>
        {value == true ? () {}() : showNoInternetSnack(_scaffoldKey)});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: 'เบอร์โทรศัพท์/อีเมล์ :',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    controller: _passController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String value) {
                      if (value == null) {
                        return 'กรุณาใส่ Password';
                      }
                      return null;
                    },
                    obscureText: _obscureText,
                    autovalidate: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFe7edeb),
                      hintText: 'รหัสผ่าน :',
                      prefixIcon: Icon(
                        Icons.vpn_key_rounded,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            iserror == true ? Text("Invalid Password") : Container(),

            SizedBox(
              height: 50,
            ),
            _isloading == true
                ? InkWell(
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color(0xff0C3455),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xff0C3455),
                    ),
                    child: InkWell(
                      onTap: () async {
                        print('กด');
                        setState(() {
                          _isloading = true;
                        });
                        await singin(
                            _emailController.text, _passController.text);
                      },
                      child: Center(
                        child: Text(
                          "เข้าสู่ระบบ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
            // Center(
            //   child: InkWell(
            //     onTap: () async {
            //       print('กด');

            //       // if (_emailController.text == "" ||
            //       //     _passController.text == "") {}

            //       setState(() {
            //         _isloading = true;
            //       });
            //       await singin(_emailController.text, _passController.text);
            //     },
            //     child: Text('เข้าสู่ระบบ'),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => Register()),
                ),
                child: Text('สมัครสมาชิก'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white, // Set border color
                            width: 3.0), // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey[200],
                              offset: Offset(1, 3))
                        ] // Make rounded corner of border
                        ),
                    // color: Colors.white,
                    child: InkWell(
                      child: Image.asset('images/logoapple.png'),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white, // Set border color
                            width: 3.0), // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey[200],
                              offset: Offset(1, 3))
                        ] // Make rounded corner of border
                        ),
                    // color: Colors.white,
                    child: InkWell(
                      child: Image.asset('images/logogoogle.png'),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.white, // Set border color
                            width: 3.0), // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey[200],
                              offset: Offset(1, 3))
                        ] // Make rounded corner of border
                        ),
                    // color: Colors.white,
                    child: InkWell(
                      child: Image.asset('images/logofb.png'),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  alertlogSc() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Invalid Password",
      content: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
              ),
            ],
          ),
        ],
      ),
      buttons: [
        DialogButton(
          child: Text(
            'Close',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            // print('$mypostid โพสของฉัน');
            // print('$checkpostidEvent โพสidอีเว้น');
            // print('$checksenderUid uidคนส่ง');

            //  if (mypostid!=checkpostidEvent) {
            //
            // }
            setState(() {
              iserror = false;
            });
            // eventreq(joinEvent);
            // sendmyeventreq(joinEvent);
            Navigator.pop(context);
          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ],
    ).show();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
