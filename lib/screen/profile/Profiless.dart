import 'dart:convert';
import 'dart:io';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postlistSSmodel.dart';
import 'package:appmove/screen/comment/commentlist.dart';
import 'package:appmove/screen/home/repostwithcomment.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/profile/postdetailss.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/utils/utils.dart';
import 'package:appmove/widgets/allWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as Http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilessScreen extends StatefulWidget {
  final String id;
  final String image;
  final String name;
  final String phonenumber;
  final String lineId;
  final String facebookUrl;
  final String twitterUrl;
  final bool isOfficial;
  final String pageUsername;
  final bool isFollow;

  const ProfilessScreen(
      {Key key,
      this.id,
      this.image,
      this.name,
      this.phonenumber,
      this.lineId,
      this.facebookUrl,
      this.twitterUrl, this.isOfficial, this.pageUsername, this.isFollow})
      : super(key: key);

  @override
  _ProfilessScreenState createState() => _ProfilessScreenState();
}

class _ProfilessScreenState extends State<ProfilessScreen> {
  List<PostListSS> listpostss = [];
  Future getPostss;
  var dataht;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  int _currentMax = 5;
  var checktoken, myuid;

  bool isLoading = false;
  var story;
  TextEditingController _detailController = TextEditingController();

  int page = 5;
  List<PostListSS> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();
  EasyRefreshController _controller;

  var phonenumber;

  @override
  void initState() {
    _controller = EasyRefreshController();

    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  setState(() {
                    Api.gettoke().then((value) => value({
                          checktoken = value,
                          print('checktoken$checktoken'),
                        }));
                    Api.getmyuid().then((value) => ({
                          setState(() {
                            myuid = value;
                          }),
                          print('myuidhome$myuid'),
                        }));
                    // scrollController = ScrollController();
                    Api.getpagess(myuid, checktoken, widget.id)
                        .then((responseData) => ({
                              print('getpagess${responseData.body}'),
                              if (responseData.statusCode == 200)
                                {
                                  dataht = jsonDecode(responseData.body),
                                  phonenumber = dataht["data"]["mobileNo"],
                                  print('phonenumber$phonenumber'),
                                }
                            }));
                    _scrollController.addListener(() {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        print('At the End');
                        setState(() {
                          _currentMax = _currentMax + 5;
                          _getMoreData(widget.id, _currentMax);
                        });
                      }
                    });

                    getPostss = _getMoreData(widget.id, _currentMax);

                    // Api.getPostListSS(widget.id).then((responseData) => ({
                    //       // setState(() {
                    //       //   loading = true;
                    //       // }),
                    //       print('getPostListSS'),
                    //       if (responseData.statusCode == 200)
                    //         {
                    //           dataht = jsonDecode(responseData.body),
                    //           print(dataht),
                    //           for (var i in dataht["data"])
                    //             {
                    //               // i["story"] = '',

                    //               listpostss.add(PostListSS.fromJson(i)),
                    //               // story = dataht["data"]["story"]["story"],
                    //               // print('story$story'),
                    //               print(listpostss.length)
                    //             },

                    //           // loading = false,
                    //         }
                    //     }));
//=============================//=============================//=============================//=============================

                    // getData();
                    // getDatasectionModels();
                  });
                }()
              : showNoInternetSnack(_scaffoldKey)
        });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future _getMoreData(String idss, int offset) async {
    final responseData = await Http.get(
        "https://today-api.moveforwardparty.org/api/page/$idss/post/?offset=$offset&limit=5");

    print('getPostListSS');
    if (responseData.statusCode == 200) {
      dataht = jsonDecode(responseData.body);
      print(dataht);
      for (var i in dataht["data"]) {
        // i["story"] = '',

        listpostss.add(PostListSS.fromJson(i));
        // story = dataht["data"]["story"]["story"],
        // print('story$story'),
        print(listpostss.length);
      }

      // loading = false,
    }
  }

  // void _getMoreData() async {
  //   _getMoreData(widget.id);
  //   print('_getMoreData');
  // }

  // void _onLoading() async {
  //   print('_onLoading');
  //   page++;
  //   var list = await Api.getPostListSS(widget.id, page: page);
  //   listpostss.addAll(list);
  // }

  void _launchSocial(String url, String fallbackUrl) async {
    print('_launchSocial');
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    if (Platform.isAndroid) {
      try {
        bool launched =
            await launch(url, forceSafariVC: false, forceWebView: false);
        if (!launched) {
          await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
        }
      } catch (e) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } else if (Platform.isIOS) {
      // iOS
      try {
        bool launched =
            await launch(url, forceSafariVC: false, forceWebView: false);
        if (!launched) {
          await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
        }
      } catch (e) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(' widget.isFollow${ widget.isFollow}');
    print('twitterUrl${widget.twitterUrl}');

    widget.facebookUrl != "" ? print('???????????????') : print('????????????????????????');

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffF47932),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "?????????????????????",
          style: TextStyle(
              color: Color(0xff0C3455),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        actions: [
          // widget.istoken == ""
          //     ? Container()
          //     : InkWell(
          //         onTap: () async {
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return SimpleDialog(
          //                   title: Text('logout??????????????????'),
          //                   children: <Widget>[
          //                     SimpleDialogOption(
          //                       onPressed: () async {
          //                         await Api.logout();
          //                         Navigator.of(context).pushAndRemoveUntil(
          //                             CupertinoPageRoute(
          //                                 builder: (BuildContext context) =>
          //                                     Appbar(
          //                                       istoken: "",
          //                                     )),
          //                             (Route<dynamic> route) => false);
          //                       },
          //                       child: Text('Yes????????'),
          //                     ),
          //                     // SimpleDialogOption(
          //                     //   onPressed: handleImageSelecting,
          //                     //   child: Text('select a pic'),
          //                     // ),
          //                     SimpleDialogOption(
          //                       child: Text('cancel?????????????????'),
          //                       onPressed: () {
          //                         Navigator.pop(context);
          //                       },
          //                     )
          //                   ],
          //                 );
          //               });
          //         },
          //         child: Icon(
          //           Icons.logout,
          //         ))
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        child: Column(children: <Widget>[
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 1, top: 10, right: 1),
            child: GestureDetector(
              onTap: () {},
              child: Column(children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 125,
                        height: 125,
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
                                image: NetworkImage(
                                    "https://today-api.moveforwardparty.org/api${widget.image}/image"),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                widget.name == null
                        ? Text(
                            'Label',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "${widget.name}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                         widget.isOfficial==true? Icon(Icons.shield,color: Color(0xffFFD700),):Container(),

                          // ${widget.isOfficial==true? Icon(Icons.shield):Text('NoOfficial')}
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                // Center(
                //   child: Container(
                //     child: Text(
                //       '?????????????????????',
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
                // widget.istoken == ""
                //     ? Container()
                //     : InkWell(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => Editprofile()),
                //           );
                //         },
                //         child: Container(
                //           height: 35,
                //           width: 100,
                //           // margin: EdgeInsets.symmetric(horizontal: 201),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(50),
                //             color: Color(0xff0C3455),
                //           ),
                //           child: Center(
                //             child: Text(
                //               "????????????????????????????????????",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
                SizedBox(
                  height: 5,
                ),
            //  widget.isFollow!=true?  InkWell(
            //                   onTap: () {
                               
            //                   },
            //                   child: Container(
            //                     height: 35,
            //                     width: 150,
            //                     // margin: EdgeInsets.symmetric(horizontal: 201),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Color(0xff0C3455),
            //                     ),
            //                     child: Center(
            //                       child: Text(
            //                         "??????????????????",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                   ),
            //                 ):InkWell(
            //                   onTap: () {
                               
            //                   },
            //                   child: Container(
            //                     height: 35,
            //                     width: 150,
            //                     // margin: EdgeInsets.symmetric(horizontal: 201),
            //                     decoration: BoxDecoration(
            //                       borderRadius: BorderRadius.circular(50),
            //                       color: Colors.orange,
            //                     ),
            //                     child: Center(
            //                       child: Text(
            //                         "??????????????????????????????",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     ),
            //                   ),
            //                 ),
                //             SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.facebookUrl != null
                        ? Container(
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
                              onTap: () async {
                                HapticFeedback.lightImpact();

                                var storytestreplaceAll;
                                storytestreplaceAll = widget.facebookUrl
                                    .replaceAll("www.facebook.com/", "");
                                print(
                                    'storytestreplaceAll$storytestreplaceAll');

                                print('??????');
                                if (Platform.isAndroid) {
                                  String uri =
                                      'fb://profile/AllMoveForwardPartyThailand';
                                  if (await canLaunch(uri)) {
                                    await launch(uri);
                                  } else {
                                    throw 'Could not launch $uri';
                                  }
                                } else if (Platform.isIOS) {
                                  // iOS
                                  try {
                                    bool launched = await launch(
                                        'fb://page/AllMoveForwardPartyThailand',
                                        forceSafariVC: false,
                                        forceWebView: false);
                                    if (!launched) {
                                      await launch(
                                          'fb://page/AllMoveForwardPartyThailand',
                                          forceSafariVC: false,
                                          forceWebView: false);
                                    }
                                  } catch (e) {
                                    await launch(
                                        'fb://page/AllMoveForwardPartyThailand',
                                        forceSafariVC: false,
                                        forceWebView: false);
                                  }
                                }
                              },
                              child: Image.asset('images/logofb.png'),
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                // color: Colors.grey[800].withOpacity(0.3),
                                border: Border.all(
                                 color: Colors.grey[800].withOpacity(0.3),
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
                              onTap: () {
                                print('??????');
                                // CupertinoAlertDialog(
                                //   title: new Text("Dialog Title"),
                                //   content: new Text("This is my content"),
                                //   actions: <Widget>[
                                //     CupertinoDialogAction(
                                //       isDefaultAction: true,
                                //       child: Text("Yes"),
                                //     ),
                                //     CupertinoDialogAction(
                                //       child: Text("No"),
                                //     )
                                //   ],
                                // );
                              },
                              child: Image.asset(
                                'images/logofbgray.png',
                                color: Colors.grey.withOpacity(0.5),
                                colorBlendMode: BlendMode.softLight,
                              ),
                            )),
                    SizedBox(
                      width: 25,
                    ),
                    //============================================
                    widget.twitterUrl != null
                        ? Container(
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
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                print('??????');
                                var twitterurlreplaceAll;
                                twitterurlreplaceAll = widget.twitterUrl
                                    .replaceAll("twitter.com/", "");
                                print(
                                    'storytestreplaceAll$twitterurlreplaceAll');
                                if (Platform.isAndroid) {
                                  String uri =
                                      'twitter://user?screen_name=$twitterurlreplaceAll';
                                  if (await canLaunch(uri)) {
                                    await launch(uri);
                                  } else {
                                    throw 'Could not launch $uri';
                                  }
                                } else if (Platform.isIOS) {
                                  // iOS
                                  String uri =
                                      'twitter://user?screen_name=$twitterurlreplaceAll';
                                  if (await canLaunch(uri)) {
                                    await launch(uri);
                                  } else {
                                    throw 'Could not launch $uri';
                                  }
                                }
                              },
                              child: Image.asset('images/logotw.png'),
                            ),
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                color: Colors.grey[800].withOpacity(0.3),
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
                              child: Image.asset(
                                'images/logotwgray.png',
                                color: Colors.grey[800].withOpacity(0.3),
                                colorBlendMode: BlendMode.softLight,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 25,
                    ),
               widget.lineId!=null?     Container(
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
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          print('??????');
                          if (Platform.isAndroid) {
                            String uri =
                                'line://oaMessage/@${widget.lineId}/123';
                            if (await canLaunch(uri)) {
                              await launch(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          } else if (Platform.isIOS) {
                            // iOS
                            String uri =
                                'line://oaMessage/@${widget.lineId}/123';
                            if (await canLaunch(uri)) {
                              await launch(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          }
                        },
                        child: Image.asset('images/logoline.png'),
                      ),
                    ):Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                color: Colors.grey[800].withOpacity(0.3),
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
                              child: Image.asset(
                                'images/logolinegray.png',
                                color: Colors.grey[800].withOpacity(0.3),
                                colorBlendMode: BlendMode.softLight,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 25,
                    ),
               widget.phonenumber!=null?     Container(
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
                        onTap: () {
                          HapticFeedback.lightImpact();

                          launch("tel://${widget.phonenumber}");
                        },
                        child: Image.asset('images/logophone.png'),
                      ),
                    ):Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(
                                color: Colors.grey[800].withOpacity(0.3),
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
                              child: Image.asset(
                                'images/logophonegray.png',
                                color: Colors.grey[800].withOpacity(0.3),
                                colorBlendMode: BlendMode.softLight,
                              ),
                            ),
                          ),
                  ],
                ),
                                    SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
          //    Container(
          //     width: double.infinity,
          //     height: 300,
          //     child: FutureBuilder(
          //       future: Future.wait([
          //        getPostss,
          //       ]),
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         return EasyRefresh.custom(
          //     enableControlFinishRefresh: false,
          //     enableControlFinishLoad: true,
          //     controller: _controller,
          //     header: ClassicalHeader(),
          //     footer: ClassicalFooter(),
          //     shrinkWrap : true,

          //     onRefresh: () async {
          //       _getMoreData(widget.id, _currentMax);
          //                       print('onRefresh');

          //       // await Future.delayed(Duration(seconds: 2), () {
          //       //   print('onRefresh');
          //       //   setState(() {
          //       //     _count = 20;
          //       //   });
          //         _controller.resetLoadState();
          //       // });
          //     },
          //     onLoad: () async {
          //                    await _getMoreData(widget.id, _currentMax);
          //         print('onLoad');

          //         // _controller.finishLoad(
          //         //   // noMore: _currentMax <= listpostss.length
          //         //   );

          //       // await Future.delayed(Duration(seconds: 2), () {
          //       //   print('onLoad');
          //       //   setState(() {
          //       //     _count += 10;
          //       //   });
          //       //   _controller.finishLoad(noMore: _count >= 40);
          //       // });
          //     },
          //     slivers: <Widget>[
          //        SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //           (context, index) {
          //           final nDataList1 = listpostss[index];

          //             return PostList(nDataList1, story);
          //           },
          //           childCount: listpostss.length,
          //         ),
          //       ),

          //     ],
          // );
          //       },
          //     ),

          //   ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                        future: Future.wait([
                          getPostss,
                        ]),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("Loading...");
                          }
                          return new Builder(
                            builder: (BuildContext context) {
                              return ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  // padding: const EdgeInsets.all(8.0),
                                  scrollDirection: Axis.vertical,
                                  itemCount: listpostss.length + 1,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    if (index == listpostss.length) {
                                      return CupertinoActivityIndicator();
                                    }

                                    if (listpostss.length == 0) {
                                      return Center(child: Text("?????????????????????????????????"));
                                    }
                                    final nDataList1 = listpostss[index];

                                    // nDataList1.story.story != "" ?print('??????story'):print("???????????????");

                                    // print(
                                    //     'coverImage=>>>${nDataList1.coverImage}');

                                    return PostList(nDataList1, story);
                                  });
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ]),
      ),
    );
  }
void _showSettingsPanel(
    String postid,
    String postpagename,
    String postcoverImage,
    String posttitle,
    String postdetail,
    String ownerimageUrl,
    DateTime createdDate,
    String postpagepageUsername,
  ) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.3,
            maxChildSize: 0.7,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                //  color: Colors.white,

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 50,
                      //  height: 50,
                      child: Divider(
                        thickness: 5,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          var jsonResponse;
                          var status;
                          bool isshow = false;

                          await Api.repost(postid, myuid, checktoken)
                              .then((response) => ({
                                    jsonResponse = jsonDecode(response.body),
                                    if (response.statusCode == 200)
                                      {
                                        status = jsonResponse["status"],
                                        print(status),
                                        if (status == 1)
                                          {
                                            setState(() {
                                              isshow = true;
                                            }),
                                          }
                                      }
                                  }));
                          Navigator.pop(context);
                          WidgetsBinding.instance.addPostFrameCallback((_) =>
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text('Posted!'),
                                backgroundColor: Color(0xffF47932),
                                behavior: SnackBarBehavior.floating,
                                duration: new Duration(milliseconds: 3000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              )));
                        },
                        child: ListTile(
                          title: Text('?????????????????????????????????????????????'),
                          leading: Icon(FontAwesome.retweet),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RepostWithComSc(
                                        postid: postid,
                                        postpagename: postpagename,
                                        postcoverImage: postcoverImage,
                                        posttitle: posttitle,
                                        postdetail: postdetail,
                                        ownerimageUrl: ownerimageUrl,
                                        createdDate: createdDate,
                                        postpagepageUsername:
                                            postpagepageUsername,
                                        token: checktoken,
                                        myuid: myuid,
                                      )));
                        },
                        child: ListTile(
                          title: Text('?????????????????????????????????????????????????????????????????????????????????????????????'),
                          leading: Icon(FontAwesome.pencil),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                          height: 5,
                        ),

                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //     // border: Border.all(width: 4, color: Colors.white),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         spreadRadius: 2,
                        //         blurRadius: 10,
                        //         color: Colors.black.withOpacity(0.1),
                        //       ),
                        //     ],
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //       fit: BoxFit.cover,
                        //       image: new NetworkImage(
                        //           "https://today-api.moveforwardparty.org/api${image}/image"),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        // Text(
                        //   '$displayName1',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 16),
                        // ),
                      ],
                    ),
                    // Container(
                    //     width: double.infinity,
                    //     height: 100,
                    //     child: TextFormField(
                    //       controller: _detailController,
                    //     )),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: ListTile(
                          title: Center(child: Text('??????????????????')),
                        ),
                      ),
                    ),
                    // RaisedButton(
                    //   child: Text(
                    //     "Share",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    //   onPressed: () async {
                    //     var jsonResponse;
                    //     var status;
                    //     bool isshow = false;
                    //     _detailController.text == ""
                    //         ? await Api.repost(postid, myuid, checktoken)
                    //             .then((response) => ({
                    //                   jsonResponse = jsonDecode(response.body),
                    //                   if (response.statusCode == 200)
                    //                     {
                    //                       status = jsonResponse["status"],
                    //                       print(status),
                    //                       if (status == 1)
                    //                         {
                    //                           setState(() {
                    //                             isshow = true;
                    //                           }),
                    //                         }
                    //                     }
                    //                 }))
                    //         : await Api.repostwithdetail(postid, myuid,
                    //                 checktoken, _detailController.text)
                    //             .then((response) => ({
                    //                   jsonResponse = jsonDecode(response.body),
                    //                   if (response.statusCode == 200)
                    //                     {
                    //                       status = jsonResponse["status"],
                    //                       print(status),
                    //                       if (status == 1)
                    //                         {
                    //                           setState(() {
                    //                             isshow = true;
                    //                             _detailController.clear();
                    //                           }),
                    //                         }
                    //                     }
                    //                 }));
                    //     Navigator.pop(context);
                    //     isshow == true
                    //         ? WidgetsBinding.instance.addPostFrameCallback(
                    //             (_) => _scaffoldKey.currentState
                    //                     .showSnackBar(SnackBar(
                    //                   content: Text('Posted!'),
                    //                   backgroundColor: Color(0xffF47932),
                    //                   behavior: SnackBarBehavior.floating,
                    //                   duration:
                    //                       new Duration(milliseconds: 3000),
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     side: BorderSide(
                    //                       color: Colors.white,
                    //                       width: 2,
                    //                     ),
                    //                   ),
                    //                 )))
                    //         : WidgetsBinding.instance.addPostFrameCallback(
                    //             (_) => _scaffoldKey.currentState
                    //                     .showSnackBar(SnackBar(
                    //                   content: Text('Error!'),
                    //                   backgroundColor: Color(0xffF47932),
                    //                   behavior: SnackBarBehavior.floating,
                    //                   duration:
                    //                       new Duration(milliseconds: 3000),
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(20),
                    //                     side: BorderSide(
                    //                       color: Colors.white,
                    //                       width: 2,
                    //                     ),
                    //                   ),
                    //                 )));
                    //   },
                    //   color: Colors.red,
                    //   textColor: Colors.white,
                    //   padding: EdgeInsets.all(8.0),
                    //   splashColor: Colors.grey,
                    // )
                  ],
                ),
                // ListView(
                //   controller: scrollController,
                //   children: const <Widget>[
                //     Card(child: ListTile(title: Text('One-line ListTile'))),
                //     Card(
                //       child: ListTile(
                //         leading: FlutterLogo(),
                //         title: Text('One-line with leading widget'),
                //       ),
                //     ),

                //   ],
                // ),
              );
            },
          );
        });
  }
  Widget PostList(nDataList1, story) {
    // String result = str.substring(
    //   startIndex + start.length,
    // );
    //   String str = nDataList1.post.coverImage;

    //   var start = '/file/';
    //    var end = "";

    //   var startIndex = str.indexOf(start);
    // final endIndex = str.indexOf(end, startIndex + start.length);

    //   var res = str.substring(startIndex + start.length);

    //   print('startIndex$startIndex');

    // print('result$result');
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetailSSScreen(
                    id: nDataList1.id,
                    htmlData: story,
                    image: nDataList1.coverImage,
                  )),
        );
        print('??????');
      },
      child: Card(
          child: ListTile(
        title: Text("${widget.name}"),
        subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
          
                Text(Utils.readTimestamp(nDataList1.createdDate.millisecondsSinceEpoch),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    )),
            //  Text('${widget.pageUsername}',
            //         style: TextStyle(
            //           fontSize: 14,
            //         )),
                // SizedBox(
                //   width: 5,
                // ),
           
            nDataList1.coverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://today-api.moveforwardparty.org/api${nDataList1.coverImage}/image",
                        placeholder: (context, url) =>
                            new CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: new Image.asset('images/placeholder.png')),
                      ),
                    ),

                    // Image.network(
                    //   "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage}/image",
                    //   errorBuilder: (BuildContext context, Object exception,
                    //       StackTrace stacktrace) {
                    //     return Image.asset('images/placeholder.png');
                    //   },
                    //   headers: headers,
                    // ),
                  )
                : const SizedBox.shrink(),
            Text(
              "${nDataList1.title}",
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black),
              // maxLines: 2,
            ),
            // Text(
            //   "${nDataList1.post.detail}",
            //   overflow: TextOverflow.clip,
            //   // style: TextStyle(color: Colors.black),
            //   // maxLines: 2,
            // ),
            SizedBox(
              height: 10,
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(nDataList1.commentCount.toString()),
                checktoken == ""
                    ? IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    : IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          print("??????");
                          var postid = nDataList1.id;
                          print("postid${nDataList1.id}");
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => CommentList(
                              myuid: myuid,
                              postid: postid,
                              token: checktoken,
                            ),
                          );
                        }),
                Spacer(),
                                Text(nDataList1.shareCount.toString()),

            checktoken == ""  ? IconButton(
                        icon: Icon(Icons.repeat),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    :    IconButton(
                    icon: Icon(Icons.repeat),
                    onPressed: () async {
                      var postid = nDataList1.id;
                      var postcoverImage = nDataList1.coverImage;
                      var posttitle = nDataList1.title;
                      var postdetail = nDataList1.detail;
                      DateTime createdDate = nDataList1.createdDate;

                      _showSettingsPanel(postid, widget.name,
                            postcoverImage,
                            posttitle,
                            postdetail,
                            widget.image,
                            createdDate,
                            widget.pageUsername);

                      print("??????like");
                    }),
                Spacer(),
                Text(nDataList1.likeCount.toString()),
             checktoken == ""  ? IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    :     IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () async {
                      var postid = nDataList1.id;
                      var jsonResponse;
                      await Api.islike(postid, myuid, checktoken)
                          .then((value) => ({
                                jsonResponse = jsonDecode(value.body),
                                print('message${jsonResponse['message']}'),
                                if (value.statusCode == 200)
                                  {
                                    if (jsonResponse['message'] ==
                                        "Like Post Success")
                                      {
                                        setState(() {
                                          nDataList1.likeCount++;
                                        }),
                                      }
                                    else if (jsonResponse['message'] ==
                                        "UnLike Post Success")
                                      {
                                        setState(() {
                                          nDataList1.likeCount--;
                                        }),
                                      }
                                  }
                              }));
                      print("??????like");
                    }),
              ],
            )
          ],
        ),
         leading: CircleAvatar(
          backgroundImage: NetworkImage(
                "https://today-api.moveforwardparty.org/api${widget.image}/image"),
          radius: 25,
        ),
    
        // trailing: Icon(icons[index])
      )),
    );
  }
}