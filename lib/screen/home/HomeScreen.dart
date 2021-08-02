import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui';
import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/model/searchpostlistModel.dart';
import 'package:appmove/screen/home/EventList.dart';
import 'package:appmove/screen/home/NavigationBar.dart';
import 'package:appmove/screen/home/search.dart';
import 'package:appmove/screen/home/searchList.dart';
import 'package:appmove/screen/home/searchbar.dart';
import 'package:appmove/screen/home/shareSc.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/profile/Profile.dart';
import 'package:appmove/screen/profile/postdetailss.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/utils/utils.dart';
import 'package:appmove/widgets/allWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appmove/screen/comment/commentlist.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  final List<String> imgList = [
    'https://www.moveforwardparty.org/wp-content/uploads/2021/06/cover-pita1421-01.jpg',
    'https://www.moveforwardparty.org/wp-content/uploads/2021/06/tfc-web-cover-02.png',
  ];
  List<PostSearchModel> listModelPostClass = [];
  List<EmergencyEventsContent> listemergencyEvents = [];
  List<SectionModelContent> listsectionModels = [];
  TextEditingController _detailController = TextEditingController();

  var loading = false;
  var islikes = false;

  final format = new DateFormat(' h:mm');
  var checktoken;
  var dataht, datapostlist, myuid, dataht1;
  Future getDataFuture,
      getDataPostListFuture,
      getDataemergencyEvents,
      getDataobjectiveEvents;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var base;
  List<EmergencyEventsContent> listModel = [];
  List<PurpleOwner> listPurpleOwner = [];
  bool isEmty = false;
  int _currentMax = 5;

  // var str = '/file/60b9d87ae9375e7025dc0c96';

// final end = 'over';

  // Future<Null> getData() async {
  //   // print('getData');
  //   setState(() {
  //     loading = true;
  //   });

  //   final responseData = await http
  //       .get("https://today-api.moveforwardparty.org/api/main/content");
  //   if (responseData.statusCode == 200) {
  //     final data = jsonDecode(responseData.body);
  //     // print(data["data"]["emergencyEvents"]["contents"]);
  //     setState(() {
  //       for (Map i in data["data"]["emergencyEvents"]["contents"]) {
  //         listModel.add(EmergencyEventsContent.fromJson(i));
  //       }
  //       loading = false;
  //     });
  //   }
  // }

  final headers = {
    "content-type": "image/jpeg",
  };

  // Future<Null> getDatasectionModels() async {
  //   print('getDatasectionModels');
  //   setState(() {
  //     loading = true;
  //   });
  //   final responseData = await http
  //       .get("https://today-api.moveforwardparty.org/api/main/content");
  //   if (responseData.statusCode == 200) {
  //     final data = jsonDecode(responseData.body);
  //     setState(() {
  //       for (Map i in data["data"]["postSectionModel"]["contents"]) {
  //         // Map test = i["post"];
  //         // print('test$test');
  //         listModelPostClass.add(PostSearchModel.fromJson(i));
  //       }
  //       loading = false;
  //     });
  //   }
  //   if (responseData.statusCode == 400) {
  //     setState(() {
  //       print('400');
  //       isEmty = true;
  //     });
  //   }
  // }

  // Create storage
  final _storage = new FlutterSecureStorage();

  var datagetuserprofile;

  var displayName1;

  var gender;

  var firstName;

  var lastName;

  var id;

  var email;

  var image;

  fetchAlbum(String urlimage) async {
    print('fetchAlbum');
    String url = urlimage;
    var displayNamereplaceAll;
    await http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        //  Uint8List image = base64Decode(response.body);
        //  print('imageUi${response.body}');
        //   String displayname = body.toString();
        //   displayNamereplaceAll = displayname.replaceAll("data:undefined;base64,","");
        //       displayNamereplaceAll = displayname.replaceAll("data:image/png;base64,","");
        //       displayNamereplaceAll = displayname.replaceAll("data:image/jpeg;base64,","");

        // print('displayNamereplaceAll$displayNamereplaceAll');
      }
      var body = jsonDecode(response.body);

      return body;
    });
    // final responseData = await http.get(
    //     "https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/");
    //     final database = jsonDecode(responseData.body);
    //     print('database$database');

    // return responseData;
  }

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  setState(() {
                    // fetchAlbum();

                    Api.getmyuid().then((value) => ({
                          setState(() {
                            myuid = value;
                          }),
                          print('myuidhome$myuid'),
                        }));

                    Api.getuserprofile(checktoken).then((responseData) => ({
                          if (responseData.statusCode == 200)
                            {
                              datagetuserprofile =
                                  jsonDecode(responseData.body),

                              loading = false,

                              // print(data["data"]["postSectionModel"]["contents"]);

                              // print("Response status :${data.statusCode}");
                              // print("Response status :${responseData.body}");
                              setState(() {
                                displayName1 = datagetuserprofile["data"]
                                    ["user"]["displayName"];
                                gender = datagetuserprofile["data"]["user"]
                                    ["gender"];
                                firstName = datagetuserprofile["data"]["user"]
                                    ["firstName"];
                                lastName = datagetuserprofile["data"]["user"]
                                    ["lastName"];
                                id = datagetuserprofile["data"]["user"]["id"];
                                email =
                                    datagetuserprofile["data"]["user"]["email"];
                                image = datagetuserprofile["data"]["user"]
                                    ["imageURL"];
                              }),

                              print('displayName1$displayName1'),
                              print('gender$gender'),
                              print('firstName$firstName'),
                              print('lastName$lastName'),
                              print('id$id'),
                              print('email$email'),

                              print(
                                  '${datagetuserprofile["data"]["user"]["username"]}'),
                            }
                        }));
                    getDataFuture =
                        Api.getHashtagData().then((responseData) => ({
                              setState(() {
                                loading = true;
                              }),
                              print('getHashtagData'),
                              if (responseData.statusCode == 200)
                                {
                                  dataht = jsonDecode(responseData.body),
                                  for (Map i in dataht["data"]
                                      ["emergencyEvents"]["contents"])
                                    {
                                      listModel.add(
                                          EmergencyEventsContent.fromJson(i)),
                                    },
                                  loading = false,
                                }
                            }));

                    _scrollController.addListener(() async {
                      if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent) {
                        print('At the End');
                        setState(() {
                          _currentMax = _currentMax + 5;
                          getDataPostListFuture = getPostList(_currentMax);
                        });
                      }
                    });
                    getDataPostListFuture = getPostList(_currentMax);

                    // getDataPostListFuture =
                    //     Api.getPostList().then((responseData) => ({
                    //           print('getPostList'),
                    //           setState(() {
                    //             loading = true;
                    //           }),
                    //           if (responseData.statusCode == 200)
                    //             {
                    //               datapostlist = jsonDecode(responseData.body),
                    //               for (Map i in datapostlist["data"]
                    //                   ["postSectionModel"]["contents"])
                    //                 {
                    //                   setState(() {
                    //                     listModelPostClass.add(
                    //                         PostSectionModelContent.fromJson(
                    //                             i));
                    //                   }),
                    //                 },
                    //               loading = false,
                    //             }
                    //           else if (responseData.statusCode == 400)
                    //             {}
                    //         }));
                    getDataemergencyEvents = Api.getPostemergencyEventsList()
                        .then((responseData) => ({
                              print('getPostList'),
                              setState(() {
                                loading = true;
                              }),
                              if (responseData.statusCode == 200)
                                {
                                  datapostlist = jsonDecode(responseData.body),
                                  for (Map i in datapostlist["data"]
                                      ["emergencyEvents"]["contents"])
                                    {
                                      setState(() {
                                        listemergencyEvents.add(
                                            EmergencyEventsContent.fromJson(i));
                                      }),
                                    },
                                  loading = false,
                                }
                              else if (responseData.statusCode == 400)
                                {}
                            }));
                    getDataobjectiveEvents = Api
                            .getPostsectionModelsEventsList()
                        .then((responseData) => ({
                              print('getPostsectionModelsEventsList'),
                              setState(() {
                                loading = true;
                              }),
                              if (responseData.statusCode == 200)
                                {
                                  datapostlist = jsonDecode(responseData.body),
                                  for (Map i in datapostlist["data"]
                                      ["sectionModels"][2]["contents"])
                                    {
                                      setState(() {
                                        listsectionModels.add(
                                            SectionModelContent.fromJson(i));
                                      }),
                                    },
                                  loading = false,
                                }
                              else if (responseData.statusCode == 400)
                                {}
                            }));
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

  Future getPostList(int offset) async {
    print('getHashtagList');
    var url = "https://today-api.moveforwardparty.org/api/main/content/search";
    final headers = {
      // "mode": "EMAIL",
      "content-type": "application/json",
    };
    Map data = {
      "keyword": [""],
      "hashtag": ["ก้าวไกล"],
      "type": "",
      "createBy": [],
      "objective": "",
      "pageCategories": [],
      "sortBy": "LASTEST_DATE",
      "filter": {"limit": 5, "offset": offset}
    };
    var body = jsonEncode(data);

    final responseData = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseData${responseData.body}');

    if (responseData.statusCode == 200) {
      datapostlist = jsonDecode(responseData.body);
      //  print('name${datapostlist["data"][i]["page"]["name"]}');

      for (Map i in datapostlist["data"]) {
        setState(() {
          listModelPostClass.add(PostSearchModel.fromJson(i));
          print(listModelPostClass.length);
        });
      }
      loading = false;
    } else if (responseData.statusCode == 400) {}
  }

  @override
  Widget build(BuildContext context) {
    // print(Jiffy(jiffy1).fromNow());
    // 7 years ago
    Api.gettoke().then((value) => value({
          checktoken = value,
        }));
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xffF47932),
          body: RefreshIndicator(
            onRefresh: () => () async {
              print('RefreshIndicator');
              await getDataFuture;
              await getDataPostListFuture;
            }(),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(left: 24, top: 5, right: 24, bottom: 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Today ${format.format(_date)}",
                              //   style: AppTheme.getTextStyle(
                              //       themeData.textTheme.bodyText2,
                              //       fontWeight: 400,
                              //       letterSpacing: 0,
                              //       color: Colors.black),
                              // ),
                              Container(
                                child: Text(
                                  "หน้าแรก",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.3,
                                    color: Colors.black,
                                    fontSize: 32,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            // Container(
                            //   padding: const EdgeInsets.all(10.0),
                            //   decoration: BoxDecoration(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(8)),
                            //   ),
                            //   child: InkWell(
                            //     onTap: () async {
                            //       print('ปุ่มกด');
                            //       // signOutGoogle(_token);
                            //       HapticFeedback.mediumImpact();
                            //       // postsNotifier.currentPost = null;
                            //       // UserDataProfileNotifier profileNotifier =
                            //       //     Provider.of<UserDataProfileNotifier>(
                            //       //         context,
                            //       //         listen: false);
                            //       // PostNotifier postsNotifier =
                            //       //     Provider.of<PostNotifier>(context,
                            //       //         listen: false);
                            //       // var navigationResult =
                            //       //     await
                            //       // if (navigationResult == true) {
                            //       //   setState(() {
                            //       //     getProfile(profileNotifier);
                            //       //     getPosts(postsNotifier);
                            //       //     getEvenReqPosts(joinNotifier);
                            //       //   });
                            //       // }
                            //       Navigator.of(context).push(
                            //         CupertinoPageRoute(
                            //           builder: (BuildContext context) =>
                            //               ChangeNotifierProvider<
                            //                   JoinNotifier>(
                            //             create: (context) => JoinNotifier(),
                            //             builder: (context, child) =>
                            //                 NotificationPage(),
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //     child: Icon(
                            //       MdiIcons.bell,
                            //       size: 18,
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            // ),

                            // Container(
                            //   padding: const EdgeInsets.all(10.0),
                            //   decoration: BoxDecoration(
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(8)),
                            //   ),
                            //   child: InkWell(
                            //     onTap: () async {
                            //       bottom_sheet(context, formValue);
                            //     },
                            //     child: Icon(
                            //       MdiIcons.settingsHelper,
                            //       size: 18,
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            // ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: const Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              margin: const EdgeInsets.only(left: 16.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                    width: 38,
                                    height: 38,
                                    color: Colors.grey[50].withOpacity(0.5),
                                    // decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.white)),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Searchbar()),
                                        ),
                                        icon: Icon(Icons.search),
                                      ),
                                    )),
                              ),
                            ),
                            checktoken == ""
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.6),
                                          offset: const Offset(4, 4),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      child: Container(
                                          width: 38,
                                          height: 38,
                                          color:
                                              Colors.grey[50].withOpacity(0.5),
                                          // decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.white)),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Intro()),
                                              ),
                                              icon: Icon(Icons.person),
                                            ),
                                          )),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.6),
                                          offset: const Offset(4, 4),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(left: 16.0),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      child: Container(
                                          width: 38,
                                          height: 38,
                                          color: Colors.white,
                                          // decoration: BoxDecoration(
                                          // border: Border.all(color: Colors.white)),
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile(
                                                          istoken: checktoken,
                                                        )),
                                              ),
                                              icon: Icon(Icons.person),
                                            ),
                                          )),
                                    ),
                                  ),
                          ],
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 16.0),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.all(Radius.circular(16)),
                        //     child: user.profilePhoto != null
                        //         ? FadeInImage.assetNetwork(
                        //             image: user.profilePhoto,
                        //             fit: BoxFit.fill,
                        //             height: 36,
                        //             width: 36,
                        //             placeholder: "assets/profile1.png",
                        //           )
                        //         : FadeInImage.assetNetwork(
                        //             image: 'assets/profile1.png',
                        //             fit: BoxFit.fill,
                        //             height: 36,
                        //             width: 36,
                        //             placeholder: "assets/profile1.png",
                        //           ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 5, bottom: 10),
                  //   // decoration: BoxDecoration(
                  //   //   border: Border.all(
                  //   //     color: Color(0xff0C3455),
                  //   //   ),
                  //   //   borderRadius: const BorderRadius.all(
                  //   //     Radius.circular(20.0),
                  //   //   ),
                  //   //   boxShadow: <BoxShadow>[
                  //   //     // BoxShadow(
                  //   //     //   color: Colors.grey.withOpacity(0.6),
                  //   //     //   offset: const Offset(4, 4),
                  //   //     //   blurRadius: 16,
                  //   //     // ),
                  //   //   ],
                  //   // ),
                  //   child: CarouselSlider(
                  //     options: CarouselOptions(
                  //       height: 170.0,
                  //       enableInfiniteScroll: false,
                  //       initialPage: 0,
                  //       viewportFraction: 0.95,
                  //       scrollPhysics: BouncingScrollPhysics(),
                  //     ),
                  //     items: imgList.map((item) {
                  //       return Builder(
                  //         builder: (BuildContext context) {
                  //           return Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             margin: EdgeInsets.symmetric(horizontal: 5.0),
                  //             decoration: BoxDecoration(
                  //               border: Border.all(
                  //                 color: Color(0xff0C3455),
                  //               ),
                  //               borderRadius: const BorderRadius.all(
                  //                 Radius.circular(10.0),
                  //               ),
                  //               boxShadow: <BoxShadow>[
                  //                 // BoxShadow(
                  //                 //   color: Colors.grey.withOpacity(0.6),
                  //                 //   offset: const Offset(4, 4),
                  //                 //   blurRadius: 16,
                  //                 // ),
                  //               ],
                  //             ),
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(10.0),
                  //               child: FadeInImage.assetNetwork(
                  //                 image: item,
                  //                 fit: BoxFit.fill,
                  //                 placeholder: "assets/images/placeholder.png",
                  //                 placeholderScale:
                  //                     MediaQuery.of(context).size.width / 2,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  loading
                      ? Center(child: CupertinoActivityIndicator())
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  'ความนิยมสำหรับคุณ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                trailing: Wrap(
                                  spacing: 2, // space between two icons
                                  children: <Widget>[
                                    // Container(
                                    //   padding: EdgeInsets.fromLTRB(1, 6, 1, 1),
                                    //   child: InkWell(
                                    //     child: Text(
                                    //       'ดูทั้งหมด',
                                    //       style: TextStyle(
                                    //           fontWeight: FontWeight.bold),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              FutureBuilder(
                                  future: Future.wait([
                                    getDataFuture,
                                  ]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (!snapshot.hasData) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return loading
                                        ? Center(
                                            child: CupertinoActivityIndicator())
                                        : Container(
                                            height: 37,
                                            child: ListView.builder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: listModel.length,
                                                itemBuilder: (
                                                  BuildContext context,
                                                  int index,
                                                ) {
                                                  final nDataList =
                                                      listModel[index];
                                                  var isHt =
                                                      listModel[index].title;

                                                  return Container(
                                                    height: 30,
                                                    margin: EdgeInsets.only(
                                                        left: 3, right: 3),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      SearchList(
                                                                        type:
                                                                            "HASHTAG",
                                                                        label:
                                                                            isHt,
                                                                      )),
                                                        );
                                                        print(
                                                            "กด${nDataList.title}");
                                                      },
                                                      child: Text(
                                                          '${nDataList.title}'),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: Color(
                                                                  0xffF47932),
                                                              shape:
                                                                  StadiumBorder()),
                                                    ),
                                                  );
                                                }),
                                          );
                                  }),

                              //=========================================================
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'เหตุการ์ณด่วน',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              FutureBuilder(
                                  future: Future.wait([
                                    getDataPostListFuture,
                                  ]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (!snapshot.hasData) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return new Builder(
                                      builder: (BuildContext context) {
                                        return ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(8.0),
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listemergencyEvents.length,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              //             if (index == listModelPostClass.length) {
                                              //   return CupertinoActivityIndicator();
                                              // }

                                              if (listemergencyEvents.length ==
                                                  0) {
                                                return Center(
                                                    child: Text("ไม่มีข้อมูล"));
                                              }
                                              final nDataList1 =
                                                  listemergencyEvents[index];

                                              // var imageNodecode=  fetchAlbum(nDataList1.coverPageUrl.toString());

                                              return PostListemergencyEvents(
                                                  nDataList1.coverPageUrl,
                                                  nDataList1.title,
                                                  nDataList1.description,
                                                  nDataList1.dateTime);
                                            });
                                      },
                                    );
                                  }),
                              Text(
                                'โพสต์ใหม่ ๆ ที่เกิดขึ้นในเดือนนี้',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              FutureBuilder(
                                  future: Future.wait([
                                    getDataPostListFuture,
                                  ]),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (!snapshot.hasData) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return new Builder(
                                      builder: (BuildContext context) {
                                        return ListView.builder(
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(8.0),
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                listModelPostClass.length,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              //             if (index == listModelPostClass.length) {
                                              //   return CupertinoActivityIndicator();
                                              // }

                                              // if(listModelPostClass.length==0){
                                              //   return Center(child: Text("ไม่มีข้อมูล"));
                                              // }
                                              final nDataList1 =
                                                  listModelPostClass[index];

                                              return PostList(
                                                base,
                                                nDataList1.page.name,
                                                nDataList1.post.coverImage,
                                                nDataList1.post.title,
                                                nDataList1.post.detail,
                                                nDataList1.post.id,
                                                nDataList1.post.likeCount
                                                    .toString(),
                                                nDataList1.page.imageUrl,
                                                nDataList1.post.createdDate,
                                                nDataList1.post.commentCount
                                                    .toString(),
                                              );
                                            });
                                      },
                                    );
                                  }),
                              //      Text('สิ่งที่กำลังเกิดขึ้นรอบตัวคุณ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              // FutureBuilder(
                              //     future: Future.wait([
                              //       getDataobjectiveEvents,
                              //     ]),
                              //     builder: (BuildContext context,
                              //         AsyncSnapshot<dynamic> snapshot) {
                              //       if (!snapshot.hasData) {
                              //         return CupertinoActivityIndicator();
                              //       }
                              //       return new Builder(
                              //         builder: (BuildContext context) {
                              //           return ListView.builder(
                              //               physics: ClampingScrollPhysics(),
                              //               shrinkWrap: true,
                              //               padding: const EdgeInsets.all(8.0),
                              //               scrollDirection: Axis.vertical,
                              //               itemCount:
                              //                   listsectionModels.length,
                              //               itemBuilder: (
                              //                 BuildContext context,
                              //                 int index,
                              //               ) {
                              //                 //             if (index == listModelPostClass.length) {
                              //                 //   return CupertinoActivityIndicator();
                              //                 // }

                              //                 // if(listModelPostClass.length==0){
                              //                 //   return Center(child: Text("ไม่มีข้อมูล"));
                              //                 // }
                              //                 final nDataList1 =
                              //                     listsectionModels[index];

                              //                 return PostsectionModels(
                              //                   nDataList1.post.title,
                              //                   // base,
                              //                   // nDataList1.post.page.name,
                              //                   // nDataList1.post.coverImage,
                              //                   // nDataList1.post.title,
                              //                   // nDataList1.post.detail,
                              //                   // nDataList1.post.id,
                              //                   // nDataList1.post.likeCount
                              //                   //     .toString(),
                              //                   // nDataList1.post.page.imageUrl,
                              //                   // nDataList1.post.createdDate,
                              //                   // nDataList1.post.commentCount.toString(),
                              //                 );
                              //               });
                              //         },
                              //       );
                              //     }),
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

    void _showSettingsPanel(String postid) {
      showModalBottomSheet<dynamic>(isScrollControlled: false, backgroundColor: Colors.transparent, context: context, builder: (context) {
       
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
        minChildSize: 0.1,
        maxChildSize: 0.9,
        expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              color: Colors.white,
              child:Column(
                children: [
                   Row(
                children: [
                 Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  // border: Border.all(width: 4, color: Colors.white),
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
                        "https://today-api.moveforwardparty.org/api${image}/image"),
                  ),
                ),
              ),
              Text('$displayName1'),
                ],
              ),
                Container(
                width: double.infinity,
                height: 100,
                child: TextFormField(
                  controller: _detailController,

                )),
                 RaisedButton(
                  child: Text("Share", style: TextStyle(fontSize: 20),),
                  onPressed: () async{
                     var jsonResponse;
                   var  status;
                   bool isshow=false;

     _detailController.text==""?       await Api.repost(postid, myuid, checktoken).then((response) => ({
                   jsonResponse = jsonDecode(response.body),

      if (response.statusCode == 200) {
        status = jsonResponse["status"],
        print(status),

        if(status==1){
               setState(() {
                 isshow=true;
         
          }),
        }
      
   
      
      }
  })):await Api.repostwithdetail(postid, myuid, checktoken,_detailController.text).then((response) => ({
        jsonResponse = jsonDecode(response.body),
      if (response.statusCode == 200) {
        status = jsonResponse["status"],
        print(status),
        if(status==1){
               setState(() {
                 isshow=true; 
                 _detailController.clear();
          }),
        }
      }
  }));
             Navigator.pop(context);
          isshow == true  ?  WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
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
                    ))):WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text('Error!'),
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

                  color: Colors.red,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                )
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


  Widget PostList(
      base,
      String postpagename,
      String postcoverImage,
      String posttitle,
      String postdetail,
      String postid,
      String postlikeCount,
      String ownerimageUrl,
      DateTime createdDate,
      String postcommentCount) {
    String imageUri = base;
    // final UriData imageUri = Uri.parse("https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/").data;
    print('imageUri$imageUri');

    var displayNamereplaceAll;
    var displayname = imageUri.toString();
    displayNamereplaceAll =
        displayname.replaceAll("data:undefined;base64,", "");
    // String base = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
    // log('data: $image');

// print('isBase64${data.isBase64}');  // Should print true
// print('contentAsBytes${data.contentAsBytes()}');

    // Uint8List image = base64Decode(data.contentAsBytes().toString());
    String imagenJson =
        "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
    Uint8List _image = base64Decode(imagenJson);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetailSSScreen(
                    id: postid,
                    htmlData: "story",
                  )),
        );
      },
      child: Card(
          child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(postpagename,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(Utils.readTimestamp(createdDate.millisecondsSinceEpoch),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),
          ],
        ),

        subtitle: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            postcoverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      "https://today-api.moveforwardparty.org/api$postcoverImage/image",
                      width: 250,
                      height: 200,
                      filterQuality: FilterQuality.medium,
                    ),
                    //  Image.memory(_image)
                    //     CachedNetworkImage(
                    //   imageUrl:
                    //       "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image",
                    //   placeholder: (context, url) =>
                    //       new CupertinoActivityIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       new Image.asset('images/placeholder.png'),
                    // ),

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
            posttitle == null
                ? Text(
                    "Lable",
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.black),
                    // maxLines: 2,
                  )
                : Text(
                    "$posttitle",
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.black),
                    // maxLines: 2,
                  ),
            postdetail == null
                ? Text(
                    "Lable",
                    overflow: TextOverflow.clip,
                    // style: TextStyle(color: Colors.black),
                    // maxLines: 2,
                  )
                : Text(
                    "$postdetail",
                    overflow: TextOverflow.clip,
                    // style: TextStyle(color: Colors.black),
                    // maxLines: 2,
                  ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(postcommentCount.toString()),
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
                          // print("postid${post.id}");
                          showCupertinoModalBottomSheet(
                            
                            context: context,
                            builder: (context) => CommentList(
                              myuid: myuid,
                              postid: postid,
                            ),
                          );
                        }),
                Spacer(),
                IconButton(
                    icon: Icon(Icons.repeat),
                    onPressed: () async {
                      _showSettingsPanel(postid);
  //                     showModalBottomSheet(
                        
  //                       context: context,
  //                       isScrollControlled: true,
  //                       isDismissible: true,
  //                        builder: (BuildContext context) {
  //   return ShareSC();
  // }
                        
  //                     );
                      // await Api.islike(postid, myuid, checktoken);
                      print("กดlike");
                    }),
                Spacer(),
                Text(postlikeCount.toString()),
                IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () async {
                      await Api.islike(postid, myuid, checktoken);
                      print("กดlike");
                    }),
              ],
            ),
            // Divider(
            //   height: 2,
            // ),
          ],
        ),
        leading: CircleAvatar(
          child: Container(
            color: Colors.white,
            child: Image.network(
                "https://today-api.moveforwardparty.org/api$ownerimageUrl/image"),
          ),
        ),

        // backgroundImage: NetworkImage(
        //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
        // trailing: Icon(icons[index])
      )),
    );
  }

  Widget PostListemergencyEvents(
      //  String postpagename,
      String postcoverImage,
      String posttitle,
      String postdetail,
      DateTime dateTime
      //  String postid,
      //  String postlikeCount,
      //  String ownerimageUrl
      ) {
    //  String imageUri= base;
    // var imageUri = Uri.parse("https://today-api.moveforwardparty.org/api$postcoverImage/");
    // print('imageUri$imageUri');

//         var displayNamereplaceAll;
//     String displayname = postcoverImage;
//     displayNamereplaceAll = displayname.replaceAll("data:undefined;base64,","");
//       // String base = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
//               // log('data: $image');

// // print('isBase64${data.isBase64}');  // Should print true
// // print('contentAsBytes${data.contentAsBytes()}');

//               // Uint8List image = base64Decode(data.contentAsBytes().toString());
//   // String imagenJson = "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
//   Uint8List _image = base64Decode(postcoverImage);
    print('postcoverImage$postcoverImage');

    return InkWell(
      onTap: () {},
      child: Card(
          child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(posttitle,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(Utils.readTimestamp(dateTime.millisecondsSinceEpoch),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                )),

            // Text("data"),
          ],
        ),
        subtitle: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            postcoverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      "https://today-api.moveforwardparty.org/api$postcoverImage/image",
                      width: 250,
                      height: 200,
                      filterQuality: FilterQuality.medium,
                    ),
                    //  Image.memory(_image)
                    //     CachedNetworkImage(
                    //   imageUrl:
                    //       "https://today-api.moveforwardparty.org/api$postcoverImage}/image",
                    //   placeholder: (context, url) =>
                    //       new CupertinoActivityIndicator(),
                    //   errorWidget: (context, url, error) =>
                    //       new Image.asset('images/placeholder.png'),
                    // ),

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
            postdetail == null
                ? Text(
                    "Lable",
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.black),
                    // maxLines: 2,
                  )
                : ExpandableText(
                    postdetail,
                    style: TextStyle(color: Colors.black),
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 5,
                    linkColor: Colors.black,
                    onExpandedChanged: (value) => print(value),
                  ),

            // Text(
            //     "$postdetail",
            //     overflow: TextOverflow.clip,
            //     style: TextStyle(color: Colors.black),
            //     // maxLines: 2,
            //   ),
            // postdetail == null
            //     ? Text(
            //         "Lable",
            //         overflow: TextOverflow.clip,
            //         // style: TextStyle(color: Colors.black),
            //         // maxLines: 2,
            //       )
            //     : Text(
            //         "$postdetail",
            //         overflow: TextOverflow.clip,
            //         // style: TextStyle(color: Colors.black),
            //         // maxLines: 2,
            //       ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     checktoken == ""
            //         ? IconButton(
            //             icon: Icon(Icons.comment),
            //             onPressed: () {
            //               showCupertinoModalBottomSheet(
            //                 context: context,
            //                 builder: (context) => Intro(),
            //               );
            //             })
            //         : IconButton(
            //             icon: Icon(Icons.comment),
            //             onPressed: () {
            //               // print("postid${post.id}");
            //               showCupertinoModalBottomSheet(
            //                 context: context,
            //                 builder: (context) => CommentList(
            //                   myuid: myuid,
            //                   postid: postid,
            //                 ),
            //               );
            //             }),
            //                           Spacer(),

            //     Icon(Icons.repeat),
            //     Spacer(),
            //  Text(postlikeCount.toString()),
            //  IconButton(
            //             icon: Icon(Icons.favorite_border),
            //             onPressed: ()async {
            //            await Api.islike(postid, myuid, checktoken);
            //            print("กดlike");
            //             }),
            //   ],
            // ),
            // Divider(
            //   height: 2,
            // ),
          ],
        ),
        // leading: CircleAvatar(
        //   child: Container(
        //     color: Colors.white,
        //     child: Image.network(
        //         "https://today-api.moveforwardparty.org/api$ownerimageUrl/image"),
        //   ),
        // ),

        // backgroundImage: NetworkImage(
        //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
        // trailing: Icon(icons[index])
      )),
    );
  }

  Widget PostsectionModels(
    // String postpagename,
    // String postcoverImage,
    String posttitle,
    // String postdetail,
    // String postid,
    // String postlikeCount,
    // String ownerimageUrl,
    // DateTime createdDate,
    // String postcommentCount
  ) {
    String imageUri = base;
    // final UriData imageUri = Uri.parse("https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/").data;
    print('imageUri$imageUri');

    var displayNamereplaceAll;
    var displayname = imageUri.toString();
    displayNamereplaceAll =
        displayname.replaceAll("data:undefined;base64,", "");
    // String base = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
    // log('data: $image');

// print('isBase64${data.isBase64}');  // Should print true
// print('contentAsBytes${data.contentAsBytes()}');

    // Uint8List image = base64Decode(data.contentAsBytes().toString());
    String imagenJson =
        "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
    Uint8List _image = base64Decode(imagenJson);

    return Card(
        child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(posttitle),
          // Text(Utils.readTimestamp(createdDate.millisecondsSinceEpoch),
          //     style: TextStyle(
          //       fontSize: 14,
          //       color: Colors.grey,
          //     )),
        ],
      ),

      // subtitle: Column(
      //   children: <Widget>[
      //     SizedBox(
      //       height: 5,
      //     ),
      //     postcoverImage != null
      //         ? Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 8.0),
      //             child: Image.memory(_image)
      //             //     CachedNetworkImage(
      //             //   imageUrl:
      //             //       "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image",
      //             //   placeholder: (context, url) =>
      //             //       new CupertinoActivityIndicator(),
      //             //   errorWidget: (context, url, error) =>
      //             //       new Image.asset('images/placeholder.png'),
      //             // ),

      //             // Image.network(
      //             //   "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage}/image",
      //             //   errorBuilder: (BuildContext context, Object exception,
      //             //       StackTrace stacktrace) {
      //             //     return Image.asset('images/placeholder.png');
      //             //   },
      //             //   headers: headers,
      //             // ),
      //             )
      //         : const SizedBox.shrink(),
      //     posttitle == null
      //         ? Text(
      //             "Lable",
      //             overflow: TextOverflow.clip,
      //             style: TextStyle(color: Colors.black),
      //             // maxLines: 2,
      //           )
      //         : Text(
      //             "$posttitle",
      //             overflow: TextOverflow.clip,
      //             style: TextStyle(color: Colors.black),
      //             // maxLines: 2,
      //           ),
      //     postdetail == null
      //         ? Text(
      //             "Lable",
      //             overflow: TextOverflow.clip,
      //             // style: TextStyle(color: Colors.black),
      //             // maxLines: 2,
      //           )
      //         : Text(
      //             "$postdetail",
      //             overflow: TextOverflow.clip,
      //             // style: TextStyle(color: Colors.black),
      //             // maxLines: 2,
      //           ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Divider(
      //       height: 2,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         Text(postcommentCount.toString()),

      //         checktoken == ""
      //             ? IconButton(
      //                 icon: Icon(Icons.comment),
      //                 onPressed: () {
      //                   showCupertinoModalBottomSheet(
      //                     context: context,
      //                     builder: (context) => Intro(),
      //                   );
      //                 })
      //             : IconButton(
      //                 icon: Icon(Icons.comment),
      //                 onPressed: () {
      //                   // print("postid${post.id}");
      //                   showCupertinoModalBottomSheet(
      //                     context: context,
      //                     builder: (context) => CommentList(
      //                       myuid: myuid,
      //                       postid: postid,
      //                     ),
      //                   );
      //                 }),

      //         Spacer(),
      //         Icon(Icons.repeat),
      //         Spacer(),
      //         Text(postlikeCount.toString()),
      //         IconButton(
      //             icon: Icon(Icons.favorite_border),
      //             onPressed: () async {
      //               await Api.islike(postid, myuid, checktoken);
      //               print("กดlike");
      //             }),
      //       ],
      //     ),
      //     // Divider(
      //     //   height: 2,
      //     // ),
      //   ],
      // ),
      // leading: CircleAvatar(
      //   child: Container(
      //     color: Colors.white,
      //     child: Image.network(
      //         "https://today-api.moveforwardparty.org/api$ownerimageUrl/image"),
      //   ),
      // ),

      // backgroundImage: NetworkImage(
      //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
      // trailing: Icon(icons[index])
    ));
  }
}
