import 'dart:async';
import 'dart:io';

import 'package:appmove/api/Api.dart';
import 'package:appmove/main.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/model/profilepost.dart';
import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:appmove/screen/profile/Editprofile.dart';
import 'package:appmove/screen/settings/settingsSc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  final String istoken;
  final String myuid;

  const Profile({
    Key key,
    this.istoken,
    this.myuid,
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
  Future getpost;

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  var datagetuserprofile;

  var myuid;

  var dataht;

  List<ProfilePostModel> listModel = [];

  var postid;

  var titletest;

  StreamController _postsController;
  List<ProfilePostModel> lists = [];
  bool iscover = false;

  var postshareid;

  File _image;

  var msg;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var cover;

  @override
  void initState() {
    print('initState');

    setState(() {
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          loading = false;
        });
      });
    });
    Api.getmyuid().then((value) => ({
          setState(() {
            myuid = value;
          }),
          print('myuidhome$myuid'),
        }));

    // Api.gettoke().then((value) => value({
    //       mytoken = value,
    //       print('mytoken$mytoken'),
    //     }));

    Api.getuserprofile(widget.istoken).then((responseData) => ({
          if (responseData.statusCode == 200)
            {
              datagetuserprofile = jsonDecode(responseData.body),
              setState(() {
                displayName1 =
                    datagetuserprofile["data"]["user"]["displayName"];
                gender = datagetuserprofile["data"]["user"]["gender"];
                firstName = datagetuserprofile["data"]["user"]["firstName"];
                lastName = datagetuserprofile["data"]["user"]["lastName"];
                id = datagetuserprofile["data"]["user"]["id"];
                email = datagetuserprofile["data"]["user"]["email"];
                image = datagetuserprofile["data"]["user"]["imageURL"];
                cover = datagetuserprofile["data"]["user"]["coverURL"];
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

    print('widgetmytoken${widget.istoken}');
    scrollController = ScrollController();
     getpost =getpostsearch(widget.myuid, mytoken, postshareid);
    // Api.getprofilepost(widget.myuid, mytoken).then((responseData) async => ({
    //       print('getprofilepost'),
    //       if (responseData.statusCode == 200)
    //         {
    //           dataht = jsonDecode(responseData.body),
    //           for (Map i in dataht["data"]["posts"])
    //             {
    //               postshareid = i["_id"],
    //               print('postid$postid'),
    //               getpost =
    //                   await getpostsearch(widget.myuid, mytoken, postshareid),
    //             },
    //         }
    //     }));

    // _postsController = new StreamController();

    super.initState();
  }

  @override
  void dispose() {
    _clear();

    super.dispose();
  }

  Future getpostsearch(String uid, String token, String postid) async {
    print('getpostsearch$postid');
    var url = "https://today-api.moveforwardparty.org/api/profile/$uid/post/search";
    final headers = {
      "authorization": "Bearer $token",
      "userid": uid,
      "content-type": "application/json",
      "accept": "application/json"
      // "whereConditions": {"isHideStory": false},
    };
    Map data = {
    "type":"",
    "offset":0,
    "limit":5
    };
    var body = jsonEncode(data);
    final responseData = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseDatagetpostsearch${responseData.body}');
    if (responseData.statusCode == 200) {
      dataht = jsonDecode(responseData.body);
      // print('getpostsearch2${responseData.body}');

      for (Map i in dataht["data"]["posts"]) {
        // titletest = i["detail"];
        listModel.add(ProfilePostModel.fromJson(i));
        // _postsController.add(responseData);

        // print('titlegetpostsearch$titletest');
        // listModel.add(ProfilePostModel.fromJson(i));
        print('listModel.length${listModel.length}');
      }
    }
  }

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
      var responseProfileImage = await Api.setimagecover(
          widget.myuid, img64, "basic-ios.png", widget.istoken);

      if (responseProfileImage != null &&
          responseProfileImage.statusCode == 200) {
        final jsonResponse = jsonDecode(responseProfileImage.body);

        if (jsonResponse['status'] == 1) {
          // _clear();

          // print(jsonResponse['message']);
          setState(() {
            msg = jsonResponse['message'];

            print('msg$msg');
            iscover = true;

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

  Future<Null> _handleRefresh() async {
    print('_handleRefresh');
    new Future.delayed(const Duration(seconds: 2));
    // setState(() {
    //   listModel.clear();
    // });
    Api.getuserprofile(widget.istoken).then((responseData) => ({
          if (responseData.statusCode == 200)
            {
              datagetuserprofile = jsonDecode(responseData.body),
              setState(() {
                displayName1 =
                    datagetuserprofile["data"]["user"]["displayName"];
                gender = datagetuserprofile["data"]["user"]["gender"];
                firstName = datagetuserprofile["data"]["user"]["firstName"];
                lastName = datagetuserprofile["data"]["user"]["lastName"];
                id = datagetuserprofile["data"]["user"]["id"];
                email = datagetuserprofile["data"]["user"]["email"];
                image = datagetuserprofile["data"]["user"]["imageURL"];
                cover = datagetuserprofile["data"]["user"]["coverURL"];
              }),
            }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            color: Colors.white,
            child: Center(child: CupertinoActivityIndicator()))
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Color(0xffF47932),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "โปรไฟล์",
                style: TextStyle(
                    color: Color(0xff0C3455),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              actions: [
              // widget.istoken == ""||widget.istoken==null
              //       ? Container()
              //       : InkWell(
              //           onTap: () async {
              //             showDialog(
              //                 context: context,
              //                 builder: (context) {
              //                   return SimpleDialog(
              //                     title: Text('logout?🤷🏻‍♂️'),
              //                     children: <Widget>[
              //                       SimpleDialogOption(
              //                         onPressed: () async {
              //                           await Api.logout();
              //                           Navigator.of(context)
              //                               .pushAndRemoveUntil(
              //                                   CupertinoPageRoute(
              //                                       builder: (BuildContext
              //                                               context) =>
              //                                           Appbar()),
              //                                   (Route<dynamic> route) =>
              //                                       false);
              //                         },
              //                         child: Text('Yes👌🏻'),
              //                       ),
              //                       // SimpleDialogOption(
              //                       //   onPressed: handleImageSelecting,
              //                       //   child: Text('select a pic'),
              //                       // ),
              //                       SimpleDialogOption(
              //                         child: Text('cancel🙅🏻‍♂️'),
              //                         onPressed: () {
              //                           Navigator.pop(context);
              //                         },
              //                       )
              //                     ],
              //                   );
              //                 });
              //           },
              //           child: Icon(
              //             Icons.logout,
              //           )),
            widget.istoken == ""||widget.istoken==null
                    ? Container():    InkWell(
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
              child: Column(
                children: <Widget>[
                   
                Container(
                  padding: EdgeInsets.only(left: 15, top: 1, right: 15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            // Text('data'),
                           Container(
                              width: 500,
                              height: 200,
                              child: Image.network(
                                  '${iscover == true ? Image.file(_image) : 'https://today-api.moveforwardparty.org/api$cover/image'}'),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                // padding: EdgeInsets.only(
                                //     left: 15, top: 5, right: 15),
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.white),
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
                                        "https://today-api.moveforwardparty.org/api$image/image"),
                                  ),
                                ),
                              ),
                            ),
                     widget.istoken == ""||widget.istoken==null?
                      Container():      Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Colors.white,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () => _showPicker(context),
                                  child: Icon(
                                    Icons.camera_enhance,
                                    color: Colors.white,
                                    size: 25,
                                  ),
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
                      widget.istoken == ""||widget.istoken==null
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.white, // Set border color
                      //               width: 3.0), // Set border width
                      //           borderRadius: BorderRadius.all(Radius.circular(
                      //               10.0)), // Set rounded corner radius
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 blurRadius: 10,
                      //                 color: Colors.grey[200],
                      //                 offset: Offset(1, 3))
                      //           ] // Make rounded corner of border
                      //           ),
                      //       // color: Colors.white,
                      //       child: InkWell(
                      //         child: Image.asset('images/logofb.png'),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 25,
                      //     ),
                      //     Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.white, // Set border color
                      //               width: 3.0), // Set border width
                      //           borderRadius: BorderRadius.all(Radius.circular(
                      //               10.0)), // Set rounded corner radius
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 blurRadius: 10,
                      //                 color: Colors.grey[200],
                      //                 offset: Offset(1, 3))
                      //           ] // Make rounded corner of border
                      //           ),
                      //       // color: Colors.white,
                      //       child: InkWell(
                      //         child: Image.asset('images/logotw.png'),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 25,
                      //     ),
                      //     Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.white, // Set border color
                      //               width: 3.0), // Set border width
                      //           borderRadius: BorderRadius.all(Radius.circular(
                      //               10.0)), // Set rounded corner radius
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 blurRadius: 10,
                      //                 color: Colors.grey[200],
                      //                 offset: Offset(1, 3))
                      //           ] // Make rounded corner of border
                      //           ),
                      //       // color: Colors.white,
                      //       child: InkWell(
                      //         child: Image.asset('images/logoline.png'),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 25,
                      //     ),
                      //     Container(
                      //       width: 40,
                      //       height: 40,
                      //       decoration: BoxDecoration(
                      //           color: Colors.white,
                      //           border: Border.all(
                      //               color: Colors.white, // Set border color
                      //               width: 3.0), // Set border width
                      //           borderRadius: BorderRadius.all(Radius.circular(
                      //               10.0)), // Set rounded corner radius
                      //           boxShadow: [
                      //             BoxShadow(
                      //                 blurRadius: 10,
                      //                 color: Colors.grey[200],
                      //                 offset: Offset(1, 3))
                      //           ] // Make rounded corner of border
                      //           ),
                      //       // color: Colors.white,
                      //       child: InkWell(
                      //         onTap: () => launch("tel://21213123123"),
                      //         child: Image.asset('images/logophone.png'),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Divider(),
                    ]),
                  ),
                ),
                // Center(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       SizedBox(
                //         height: 20,
                //       ),
                //       Padding(
                //         padding: EdgeInsets.all(20),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: <Widget>[
                //             FutureBuilder(
                //               future: Future.wait([
                //                 getpost,
                //               ]),
                //               // initialData: InitialData,
                //               builder: (BuildContext context,
                //                   AsyncSnapshot snapshot) {
                //                 return ListView.builder(
                //                     physics: ClampingScrollPhysics(),
                //                     shrinkWrap: true,
                //                     padding: const EdgeInsets.all(8.0),
                //                     scrollDirection: Axis.vertical,
                //                     itemCount: listModel.length,
                //                     itemBuilder: (
                //                       BuildContext context,
                //                       int index,
                //                     ) {
                //                       var data = listModel[index];
                //                       if (listModel.length == 0) {
                //                         return CupertinoActivityIndicator();
                //                       }
                //                       // var mypostid = data.referencePost;
                //                       // print('mypostid$mypostid');

                //                       return ListTile(
                //                         title: Text('data${data.title}'),
                //                         subtitle: Text('data'),
                //                       );
                //                     });
                //               },
                //             ),

                //             // StreamBuilder(
                //             //   stream: _postsController.stream,
                //             //   builder: (BuildContext context,
                //             //       AsyncSnapshot snapshot) {
                //             //     return ListView.builder(
                //             //         physics: ClampingScrollPhysics(),
                //             //         shrinkWrap: true,
                //             //         padding: const EdgeInsets.all(8.0),
                //             //         scrollDirection: Axis.vertical,
                //             //         itemCount: listModel.length,
                //             //         itemBuilder: (
                //             //           BuildContext context,
                //             //           int index,
                //             //         ) {
                //             //           var data = listModel[index];
                //             //           if (listModel.length == 0) {
                //             //             return CupertinoActivityIndicator();
                //             //           }
                //             //           // var mypostid = data.referencePost;
                //             //           // print('mypostid$mypostid');

                //             //           return ListTile(
                //             //             title: Text('data${data.title}'),
                //             //             subtitle: Text('data'),
                //             //           );
                //             //         });
                //             //   },
                //             // ),

                //             // Builder(
                //             //   builder: (BuildContext context) {
                //             //     return ListView.builder(
                //             //         physics: ClampingScrollPhysics(),
                //             //         shrinkWrap: true,
                //             //         padding: const EdgeInsets.all(8.0),
                //             //         scrollDirection: Axis.vertical,
                //             //         itemCount: listModel.length,
                //             //         itemBuilder: (
                //             //           BuildContext context,
                //             //           int index,
                //             //         ) {
                //             //           var data = listModel[index];
                //             //           if (listModel.length == 0) {
                //             //             return CupertinoActivityIndicator();
                //             //           }
                //             //           var mypostid = data.referencePost;
                //             //           print('mypostid$mypostid');
                //             //           Api.getpostsearch(widget.myuid, mytoken,mypostid)
                //             //    .then((responseData) => ({
                //             //      print('getpostsearch'),
                //             //   if (responseData.statusCode == 200)
                //             //  {
                //             //     dataht = jsonDecode(responseData.body),
                //             //         print('getpostsearch2${responseData.body}'),

                //             //       for (Map i in dataht["data"])
                //             //      {
                //             //       titletest= i["detail"],
                //             //        print('titlegetpostsearch$titletest'),
                //             //          // listModel.add(ProfilePostModel.fromJson(i)),
                //             //      },
                //             //    }
                //             //       }));

                //             //           return ListTile(
                //             //               title: Text('data${data.detail}'),
                //             //               subtitle: Text('data$titletest'),
                //             //               );
                //             //         });
                //             //   },
                //             // ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: 30),
                //     ],
                //   ),
                // ),
              ]),
            ),
          );
  }
}
