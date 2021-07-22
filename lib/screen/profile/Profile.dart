import 'package:appmove/api/Api.dart';
import 'package:appmove/main.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/screen/home/appbar.dart';
import 'package:appmove/screen/profile/Editprofile.dart';
import 'package:appmove/screen/settings/settingsSc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  final String istoken;

  const Profile({
    Key key,
    this.istoken,
  }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  ScrollController scrollController;

  var checktoken;
  var mytoken;
  String displayName1;
  int gender;
  bool loading = true;
  List<User> listUser = [];

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  var datagetuserprofile;

  // Future getuser() async {
  //   print('getuser');
  //   setState(() {
  //     loading = true;
  //   });
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   final storage = new FlutterSecureStorage();

  //   final responseData = await http.get(
  //       "https://today-api.moveforwardparty.org/api/check_status?token=${widget.istoken}");
  //   if (responseData.statusCode == 200) {
  //     final data = jsonDecode(responseData.body);

  //     loading = false;

  //     // print(data["data"]["postSectionModel"]["contents"]);

  //     // print("Response status :${data.statusCode}");
  //     // print("Response status :${responseData.body}");
  //     setState(() {
  //       displayName1 = data["data"]["user"]["displayName"];
  //       gender = data["data"]["user"]["gender"];
  //       firstName = data["data"]["user"]["firstName"];
  //       lastName = data["data"]["user"]["lastName"];
  //       id = data["data"]["user"]["id"];
  //       email = data["data"]["user"]["email"];
  //               image = data["data"]["user"]["imageURL"];

  //     });

  //     print('displayName1$displayName1');
  //     print('gender$gender');
  //     print('firstName$firstName');
  //     print('lastName$lastName');
  //     print('id$id');
  //     print('email$email');

  //     print('${data["data"]["user"]["username"]}');
  //   }
  // }

  @override
  void initState() {
        print('initState');

    setState(() {
      
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        loading = false;
      });
    });
    // Api.gettoke().then((value) => value({
    //       mytoken = value,
    //     }));
    // getuser();
    Api.getuserprofile(widget.istoken).then((responseData) => ({
      if (responseData.statusCode == 200) {
       datagetuserprofile = jsonDecode(responseData.body),

      loading = false,

      // print(data["data"]["postSectionModel"]["contents"]);

      // print("Response status :${data.statusCode}");
      // print("Response status :${responseData.body}");
      setState(() {
        displayName1 = datagetuserprofile["data"]["user"]["displayName"];
        gender = datagetuserprofile["data"]["user"]["gender"];
        firstName = datagetuserprofile["data"]["user"]["firstName"];
        lastName = datagetuserprofile["data"]["user"]["lastName"];
        id = datagetuserprofile["data"]["user"]["id"];
        email = datagetuserprofile["data"]["user"]["email"];
                image = datagetuserprofile["data"]["user"]["imageURL"];

      }),

      print('displayName1$displayName1'),
      print('gender$gender'),
      print('firstName$firstName'),
      print('lastName$lastName'),
      print('id$id'),
      print('email$email'),

      print('${datagetuserprofile["data"]["user"]["username"]}'),
    }

    }));
 
    print('mytoken${widget.istoken}');
    scrollController = ScrollController();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            child: Center(child: CupertinoActivityIndicator()))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF47932),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "โปรไฟล์ User",
                style: TextStyle(
                    color: Color(0xff0C3455),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              actions: [
                widget.istoken == ""
                    ? Container()
                    : InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: Text('logout?🤷🏻‍♂️'),
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      onPressed: () async {
                                        await Api.logout();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                CupertinoPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        Appbar(
                                                          istoken: "",
                                                        )),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      child: Text('Yes👌🏻'),
                                    ),
                                    // SimpleDialogOption(
                                    //   onPressed: handleImageSelecting,
                                    //   child: Text('select a pic'),
                                    // ),
                                    SimpleDialogOption(
                                      child: Text('cancel🙅🏻‍♂️'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                );
                              });
                        },
                        child: Icon(
                          Icons.logout,
                        )),
                InkWell(
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              child: Stack(children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(children: [
                      Center(
                        child: Stack(
                          children: [
                           Container(
                      padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
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
                           image: new NetworkImage("https://today-api.moveforwardparty.org/api$image/image"),

                        ),
                      ),
                    ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 15, top: 10, right: 15),
                          child: displayName1 == null
                              ? Text(
                                  'Label',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  '$displayName1',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      // Center(
                      //   child: Container(
                      //     child: Text(
                      //       'ตำแหน่ง',
                      //       style: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.grey),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 9,
                      ),
                      widget.istoken == ""
                          ? Container()
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Editprofile(
                                            displayName: displayName1,
                                            gender: gender.toString(),
                                            firstName: firstName,
                                            lastName: lastName,
                                            mytoken: widget.istoken,
                                            id: id,
                                            email: email,
                                            image: image,
                                          )),
                                );
                              },
                              child: Container(
                                height: 35,
                                width: 150,
                                // margin: EdgeInsets.symmetric(horizontal: 201),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xff0C3455),
                                ),
                                child: Center(
                                  child: Text(
                                    "แก้ไขโปรไฟล์",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.white, // Set border color
                                    width: 3.0), // Set border width
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // Set rounded corner radius
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // Set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey[200],
                                      offset: Offset(1, 3))
                                ] // Make rounded corner of border
                                ),
                            // color: Colors.white,
                            child: InkWell(
                              child: Image.asset('images/logotw.png'),
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // Set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey[200],
                                      offset: Offset(1, 3))
                                ] // Make rounded corner of border
                                ),
                            // color: Colors.white,
                            child: InkWell(
                              child: Image.asset('images/logoline.png'),
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
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0)), // Set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey[200],
                                      offset: Offset(1, 3))
                                ] // Make rounded corner of border
                                ),
                            // color: Colors.white,
                            child: InkWell(
                              child: Image.asset('images/logophone.png'),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 300,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ]),
            ),
          );
  }
}
