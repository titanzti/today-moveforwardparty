import 'dart:convert';
import 'package:appmove/main.dart';
import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _pass = TextEditingController();
  // final TextEditingController _confirmPass = TextEditingController();
  bool _checkbox = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passconfController = TextEditingController();

  TextEditingController _displayNameController = TextEditingController();
  TextEditingController _emaileController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _uniqueIdController = TextEditingController();
  TextEditingController _customGenderController = TextEditingController();

  String _genderman;
  String _genderlady;

  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;
  List<String> text = ["InduceSmile.com", "Flutter.io", "google.com"];
  bool _isChecked = true;
  String _currText = '';
  Color bulbColor = Colors.black;
  bool _obscureText = true;
  bool _obscureTextcon = true;

  int genderselect;
  bool genderother = false;
  String msg = "";
  bool isregister =false;

  var mytoken;
  bool _autoValidate = false;

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<http.Response> Register(
    String email,
    String password,
    String displayName,
    String username,
    String firstName,
    String lastName,
    String uniqueId,
    // DateTime birthdate,
    int gender,
    String customGender,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var url = "https://today-api.moveforwardparty.org/api/register";
      final headers = {
        "mode": "EMAIL",
        "content-type": "application/json",
      };

      Map data = {
        "username": username,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "uniqueId": uniqueId,
        "birthdate": "2021-06-01T17:00:00.000Z",
        "gender": gender,
        "customGender": customGender,
        "asset": {},
      };
      //encode Map to JSON
      var body = jsonEncode(data);
      print(body);

      var responsepostRequest =
          await http.post(url, headers: headers, body: body);
      print("${responsepostRequest.statusCode}");
      print("${responsepostRequest.body}");
      final jsonResponse = jsonDecode(responsepostRequest.body);
      print('Registerbody${responsepostRequest.body}');

      if (responsepostRequest.statusCode == 200) {

        mybody = jsonResponse["data"];
          if (jsonResponse['status'] == 1) {

          print(jsonResponse['message']);
          setState(() {
                    isregister=true;

                                    msg = jsonResponse['message'];

          print("Response status :${jsonResponse.statusCode}");
        print("Response status :${jsonResponse.body}");
        sharedPreferences.setString(
            "token", '${jsonResponse["data"]["token"]}');
        mytoken = jsonResponse["data"]["token"];
          });
        }
       
        
      }
      if (jsonResponse.statusCode == 400) {
        if (jsonResponse['status'] == 0) {
          print(jsonResponse['message']);
          setState(() {
            msg = jsonResponse['message'];
            print('msg$msg');
            // _isloading = false;

            // iserror = true;
          });
        }
      }

      return responsepostRequest;
    } catch (e) {}
  }

  String email,
      password,
      conpasswd,
      firstName,
      lastName,
      displayName,
      uniqueId,
      citizenId,
      gender,
      customGender,
      _finalpasswd;
  bool isvalidator = false;
  bool _isButtonDisabled = false;
  var mybody;
  // Future register(
  //     // email, password, displayName
  //     ) async {
  //   print('register');

  //   try {
  //     final response = await http.post(
  //       Uri.parse('https://today-api.moveforwardparty.org/api/register'),
  //       headers: {"mode": "EMAIL"},
  //       body: json.encode(<String, String>{
  //         "email": "ffff@test.com",
  //         "password": "12345678",
  //         "displayName": "test123",
  //       }),
  //     );
  //     print("${response.statusCode}");
  //     print("${response.body}");
  //     return response;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ExpandableText(
            mybody.toString(),
            expandText: 'show more',
            collapseText: 'show less',
            maxLines: 1,
            linkColor: Colors.blue,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    setState(() {
      //  vat secc = postRequest().
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var form = new Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Container(
        // color: Colors.white,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // SizedBox(height: 200,),

                      Container(
                        color: Color(0xffF47932),
                        width: double.infinity,
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'สมัครสมาชิก',
                            style: TextStyle(
                                color: Color(0xff0C3455),
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        ),
                        // decoration: BoxDecoration(
                        //     color: Color(0xffF47932),
                        //     borderRadius: BorderRadius.only(
                        //         bottomRight: Radius.circular(50))),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          
                            controller: _displayNameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: 'ชื่อที่ต้องการแสดง:',
                            ),
                            onSaved: (String value) {
                              displayName = value;
                            },
                            onChanged: (String value) {
                              displayName = value;
                              print(displayName);
                            },
                            validator: (value) =>
                                value.isEmpty ? 'กรุณาใส่ยูสเซอร์เนม' : null),
                      ),

                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                            controller: _uniqueIdController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: '@ยูสเซอร์เนม:',
                            ),
                            onSaved: (String value) {
                              displayName = value;
                            },
                            onChanged: (String value) {
                              displayName = value;
                              print(displayName);
                            },
                            validator: (value) =>
                                value.isEmpty ? 'กรุณาใส่ยูสเซอร์เนม' : null),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _firstNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: 'ชื่อ:',
                          ),
                          onSaved: (String value) {
                            firstName = value;
                          },
                          onChanged: (String value) {
                            firstName = value;
                            print(firstName);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณา ใส่ชื่อ';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _lastNameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: 'นามสกุล:',
                          ),
                          onSaved: (String value) {
                            lastName = value;
                          },
                          onChanged: (String value) {
                            lastName = value;
                            print(lastName);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุุณาใส่ นามสกุล';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: 'อีเมล์:',
                          ),
                          onSaved: (String value) {
                            email = value;
                          },
                          onChanged: (String value) {
                            email = value;
                            print(email);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'กรุณาใส่ อีเมล์';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _passController,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: 'รหัสผ่าน:',
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
                          onSaved: (String value) {
                            password = value;
                          },
                          onChanged: (String value) {
                            password = value;
                            print(email);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a password';
                            }

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: _passconfController,
                          obscureText: _obscureTextcon,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: 'คอนเฟิร์มรหัสผ่าน:',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureTextcon
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: _togglecon,
                            ),
                          ),
                          onSaved: (String value) {
                            conpasswd = value;
                          },
                          onChanged: (String value) {
                            conpasswd = value;
                            print(conpasswd);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a confirmpassword';
                            }

                            return null;
                          },
                        ),
                      ),
                     
                      isvalidator
                          ? Text(
                              'Error password not match',
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            )
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                    value: Colors.red,
                                    groupValue: bulbColor,
                                    onChanged: (val) {
                                      bulbColor = val;
                                      setState(() {
                                        int genderman = 0;
                                        genderother = false;

                                        genderselect = genderman;

                                        print('test$genderselect');
                                      });
                                    }),
                                Text('ชาย'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            // width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                    value: Colors.blue,
                                    groupValue: bulbColor,
                                    onChanged: (val) {
                                      bulbColor = val;
                                      setState(() {
                                        int genderlady = 1;
                                        genderother = false;

                                        genderselect = genderlady;
                                        print('genderselect$genderselect');
                                      });
                                    }),
                                Text('หญิง'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Radio(
                                    value: Colors.green,
                                    groupValue: bulbColor,
                                    onChanged: (val) {
                                      bulbColor = val;
                                      setState(() {
                                        genderother = true;
                                      });
                                    }),
                                Text('อื่นๆ'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      genderother == true
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: _customGenderController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFe7edeb),
                                  hintText: 'เพศ:',
                                ),
                                onSaved: (String value) {
                                  gender = value;
                                },
                                onChanged: (String value) {
                                  gender = value;
                                  print(gender);
                                },
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a _customGender';
                                  }

                                  return null;
                                },
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 10,
                      ),

                      _isButtonDisabled == true
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
                          : InkWell(
                              onTap: () async {
                                _validateInputs();
                                await Register(
                                  _emailController.text,
                                  _passController.text,
                                  _displayNameController.text,
                                  _emaileController.text,
                                  _firstNameController.text,
                                  _lastNameController.text,
                                   _uniqueIdController.text,
                                 genderselect,
                                 ""
                                //  _customGenderController.text == "".toString()
                                  // genderother == true
                                  //     ? _customGenderController.text
                                  //     : _customGenderController.text == "",
                                );
                                //                                 // if (mounted) {
                                //                                 //   setState(() {
                                //                                 //     _isButtonDisabled = true;
                                //                                 //   });
                                //                                 // }
                                //                                 // _isButtonDisabled
                                //                                 //   ? null
                                //                                 //   : await postRequest(
                                //                                 //       _emailController.text,
                                //                                 //       _passController.text,
                                //                                 //       _displayNameController.text,
                                //                                 //       _emaileController.text,
                                //                                 //       _firstNameController.text,
                                //                                 //       _lastNameController.text,
                                //                                 //       _uniqueIdController.text,
                                //                                 //     );

                                //                                 showDialog(
                                //                                     context: context,
                                //                                     builder: (context) {
                                //                                       return SimpleDialog(
                                //                                         title: Text('logout?🤷🏻‍♂️'),
                                //                                         children: <Widget>[
                                //                                           SimpleDialogOption(
                                //                                             onPressed: () async {
                                //                                               Navigator.pop(context);
                                //                                             },
                                //                                             child: Text('Next'),
                                //                                           ),
                                //                                         ],
                                //                                       );
                                //                                     });
                                print('isregister$isregister');
                                isregister==true ?showAlertDialog(context):showAlertDialogNo(context);
                          
                                     
                                
                              },
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff0C3455),
                                ),
                                child: Center(
                                  child: Text(
                                    "ยืนยันการสมัคร",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF47932),
            actions: [],
          ),
          backgroundColor: Colors.white,
          body: form,
        ),
      ),
    );
  }
 showAlertDialog(BuildContext context) {
  // set up the buttons

  Widget continueButton = TextButton(
    child: Text("Next"),
    onPressed:  () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                 
                  )),
        );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Register"),
    content: Text('สำเร็จค้าบบบ'),
    actions: [
      
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
showAlertDialogNo(BuildContext context ) {
  // set up the button
 
  Widget continueButton = TextButton(
    child: Text("Next"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Register"),
    content: Text('ไม่สำเร็จค้าบบ'),
    actions: [
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  
  void _togglecon() {
    setState(() {
      _obscureTextcon = !_obscureTextcon;
    });
  }
}
