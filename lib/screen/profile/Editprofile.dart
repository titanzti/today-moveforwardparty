import 'dart:convert';
import 'dart:io';

import 'package:appmove/api/Api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  final String mytoken;
  final String id;
  final String displayName;
  final String username;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String image;

  final String customGender;

  const Editprofile(
      {Key key,
      this.displayName,
      this.username,
      this.firstName,
      this.lastName,
      this.gender,
      this.customGender,
      this.mytoken,
      this.id,
      this.email,
      this.image})
      : super(key: key);
  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  bool _isloading = false;
  bool _isSnack = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var msg, mybody;
  String gender;
  bool genderother = false;
  Color bulbColor = Colors.black;
  int selecr;
  String genderselect;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passconfController = TextEditingController();

  TextEditingController _displayNameController;
  TextEditingController _emaileController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _uniqueIdController = TextEditingController();
  TextEditingController _customGenderController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String displayName;
  String username;
  String firstName;
  String lastName;
  // DateTime birthdate,
  String genderinit;
  String customGender;

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Future getImage() async {
    print("getImage");

    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });

      final bytes = File(image.path).readAsBytesSync();

      String img64 = base64Encode(bytes);
      print(img64);
      var responseProfileImage = await Api.updataimage(
          widget.id, img64, "basic-ios.png", widget.mytoken);

      if (responseProfileImage != null &&
          responseProfileImage.statusCode == 200) {
        final jsonResponse = jsonDecode(responseProfileImage.body);

        if (jsonResponse['status'] == 1) {
          _clear();

          // print(jsonResponse['message']);
          setState(() {
            msg = jsonResponse['message'];

            print('msg$msg');
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text('Updata succeed'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    )));
            // iserror = true;
          });
        }
      }
      // showMessage('Profile Image not uploaded', false);
    }
  }

  /// Remove image
  void _clear() {
    setState(() => _image = null);
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        getImage();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<http.Response> editprofile(
      String displayName,
      String username,
      String firstName,
      String lastName,
      // DateTime birthdate,
      int gender,
      String customGender,
      String token,
      String id) async {
    print("editprofile");
    try {
      var url = "https://today-api.moveforwardparty.org/api/profile/$id";
      final headers = {
        "authorization": "Bearer $token",
        "content-type": "application/json",
      };

      Map data = {
        "username": username,
        "displayName": displayName,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "customGender": customGender,
        // "isAdmin": false,
        // "isSubAdmin": false,
        // "imageURL": "",
        // "coverURL": "",
        // "coverPosition": 0,
        // "banned": false,
        // "asset": {},
      };
      //encode Map to JSON
      var body = jsonEncode(data);

      var responsepostRequest =
          await http.put(url, headers: headers, body: body);
      print("${responsepostRequest.statusCode}");
      print("${responsepostRequest.body}");
      final jsonResponse = jsonDecode(responsepostRequest.body);

      if (responsepostRequest.statusCode == 200) {
        mybody = jsonResponse["data"];
        // print("Response status :${jsonResponse.statusCode}");
        // print("Response status :${jsonResponse.body}");
        if (jsonResponse != null) {
          if (jsonResponse['status'] == 1) {
            print('status == 1');
            // print(jsonResponse['message']);
            setState(() {
              //  msg = jsonResponse['message'];
              // print('msg$msg');
              _isloading = false;
              Navigator.pop(context);

              // iserror = true;
            });
          }
        } else {
          setState(() {
            _isloading = false;
          });
        }
      }
      if (jsonResponse.statusCode == 400) {
        // print(jsonResponse['message']);

        if (jsonResponse['status'] == 0) {
          // print(jsonResponse['message']);
          setState(() {
            //  msg = jsonResponse['message'];
            print('msg$msg');
            _isloading = false;

            // iserror = true;
          });
        }
      }

      return responsepostRequest;
    } catch (e) {}
  }

  @override
  void initState() {
    setState(() {
      selecr = int.parse(widget.gender);
      if (_isSnack == true) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          elevation: 10.0,
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });
    print('gender${widget.gender}');
    // if(widget.gender==0){}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(selecr);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 14,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Color(0xffF47932),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "แก้ไขโปรไฟล์",
          style: TextStyle(
              color: Color(0xff0C3455),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: <Widget>[
                  Container(
                      child: GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        _image != null
                            ? InkWell(
                                onTap: () => _showPicker(context),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: FileImage(_image),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () => _showPicker(context),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15, top: 10, right: 15),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          "https://today-api.moveforwardparty.org/api${widget.image}/image"),
                                    ),
                                  ),
                                ),
                              ),
                        //             Positioned(
                        //               bottom: 0,
                        //               right: 0,
                        //               child: Center(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       _showPicker(context);
                        //     },
                        //     child: CircleAvatar(
                        //       radius: 55,
                        //       backgroundColor: Color(0xffFDCF09),
                        //       child: _image != null
                        //           ? ClipRRect(
                        //               borderRadius: BorderRadius.circular(50),
                        //               child: Image.file(
                        //                 _image,
                        //                 width: 150,
                        //                 height: 150,
                        //                 fit: BoxFit.fitHeight,
                        //               ),
                        //             )
                        //           : ClipRRect(
                        //               borderRadius: BorderRadius.circular(50),
                        //               child: CachedNetworkImage(
                        //                 imageUrl:
                        //                     "https://today-api.moveforwardparty.org/api${widget.image}/image",width: 150,height: 150,
                        //                 placeholder: (context, url) =>
                        //                     new CupertinoActivityIndicator(),
                        //                 errorWidget: (context, url, error) =>
                        //                     Container(
                        //                         decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.all(Radius.circular(8)),
                        //                       ),
                        //                       child: new Image.asset('images/placeholder.png')),
                        //               ),
                        //             )

                        //     ),
                        //   ),
                        // )

                        //             ),
                      ],
                    ),
                  ))
                ]),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    initialValue: widget.displayName,
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
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    initialValue: widget.firstName,
                    keyboardType: TextInputType.text,
                    // controller: _firstNameController,
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
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    initialValue: widget.lastName,
                    keyboardType: TextInputType.text,
                    // controller: _lastNameController,
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
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                              value: 0,
                              groupValue: selecr,
                              onChanged: (val) {
                                selecr = val;
                                setState(() {
                                  String genderman = "0";
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
                              value: 1,
                              groupValue: selecr,
                              onChanged: (val) {
                                selecr = val;
                                setState(() {
                                  String genderlady = "1";
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
                          // controller: _customGenderController,
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
                SizedBox(
                  height: 20,
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
                        margin: EdgeInsets.symmetric(horizontal: 16),
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
                            _formKey.currentState.save();
                            await editprofile(
                                displayName,
                                widget.email,
                                firstName,
                                lastName,
                                selecr,
                                genderother == true ? "" : "",
                                widget.mytoken,
                                widget.id);
                          },
                          child: Center(
                            child: Text(
                              "แก้ไข",
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
      ),
    );
  }
}
