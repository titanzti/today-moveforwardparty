import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/screen/home/EventList.dart';
import 'package:appmove/screen/home/appbar.dart';
import 'package:appmove/screen/home/search.dart';
import 'package:appmove/screen/home/searchList.dart';
import 'package:appmove/screen/home/searchbar.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/profile/Profile.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/widgets/allWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  ScrollController scrollController;
  final List<String> imgList = [
    'https://www.moveforwardparty.org/wp-content/uploads/2021/06/cover-pita1421-01.jpg',
    'https://www.moveforwardparty.org/wp-content/uploads/2021/06/tfc-web-cover-02.png',
  ];
  List<PostSectionModelContent> listModelPostClass = [];

  var loading = false;
  final format = new DateFormat(' h:mm');
  var checktoken;
  var dataht, datapostlist, myuid,   dataht1;
  Future getDataFuture, getDataPostListFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
var base;
  List<EmergencyEventsContent> listModel = [];
  List<PurpleOwner> listPurpleOwner = [];
  bool isEmty = false;
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

  Future<Null> getDatasectionModels() async {
    print('getDatasectionModels');
    setState(() {
      loading = true;
    });
    final responseData = await http
        .get("https://today-api.moveforwardparty.org/api/main/content");
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map i in data["data"]["postSectionModel"]["contents"]) {
          // Map test = i["post"];
          // print('test$test');
          listModelPostClass.add(PostSectionModelContent.fromJson(i));
        }
        loading = false;
      });
    }
    if (responseData.statusCode == 400) {
      setState(() {
        print('400');
        isEmty = true;
      });
    }
  }

  // Create storage
  final _storage = new FlutterSecureStorage();

//  Future<http.Response> fetchAlbum( ) async{
//  print('fetchAlbum');
//  String url =  "https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/";
//  await http.get(Uri.parse(url)).then((response ){
//    if(response.statusCode==200){
//     //  Uint8List image = base64Decode(response.body);
//     //  print('imageUi${response.body}');
//    }

//    var body =jsonDecode(response.body);
//         print('imageUi$body');

//    return body;

//  });
//     // final responseData = await http.get(
//     //     "https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/");
//     //     final database = jsonDecode(responseData.body);
//     //     print('database$database');

//   // return responseData;
// }

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  setState(() {
                    // fetchAlbum();
                    scrollController = ScrollController();

                    Api.getmyuid().then((value) => ({
                          setState(() {
                            myuid = value;
                          }),
                          print('myuidhome$myuid'),
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
                    getDataPostListFuture =
                        Api.getPostList().then((responseData) => ({
                              print('getPostList'),
                              setState(() {
                                loading = true;
                              }),
                              if (responseData.statusCode == 200)
                                {
                                  datapostlist = jsonDecode(responseData.body),
                                  for (Map i in datapostlist["data"]
                                      ["postSectionModel"]["contents"])
                                    {
                                         setState(() {
                               listModelPostClass.add(
                                          PostSectionModelContent.fromJson(i));
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
    super.dispose();
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
              controller: scrollController,
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
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 10),
                    // decoration: BoxDecoration(
                    //   border: Border.all(
                    //     color: Color(0xff0C3455),
                    //   ),
                    //   borderRadius: const BorderRadius.all(
                    //     Radius.circular(20.0),
                    //   ),
                    //   boxShadow: <BoxShadow>[
                    //     // BoxShadow(
                    //     //   color: Colors.grey.withOpacity(0.6),
                    //     //   offset: const Offset(4, 4),
                    //     //   blurRadius: 16,
                    //     // ),
                    //   ],
                    // ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 170.0,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        viewportFraction: 0.95,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      items: imgList.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff0C3455),
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: <BoxShadow>[
                                  // BoxShadow(
                                  //   color: Colors.grey.withOpacity(0.6),
                                  //   offset: const Offset(4, 4),
                                  //   blurRadius: 16,
                                  // ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: FadeInImage.assetNetwork(
                                  image: item,
                                  fit: BoxFit.fill,
                                  placeholder: "assets/images/placeholder.png",
                                  placeholderScale:
                                      MediaQuery.of(context).size.width / 2,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
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
                                              final nDataList1 =
                                                  listModelPostClass[index];

                                                


                                              return PostList(nDataList1,base);
                                            });
                                      },
                                    );
                                  }),
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
 

  Widget PostList(nDataList1,base) {
      
                             
   String imageUri= base;
                  // final UriData imageUri = Uri.parse("https://today-api.moveforwardparty.org/api/file/60d29d10d9b235079c054f9a/").data;
                  print('imageUri$imageUri');


        var displayNamereplaceAll;
    var displayname = imageUri.toString();
    displayNamereplaceAll = displayname.replaceAll("data:undefined;base64,","");
      // String base = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
              // log('data: $image');

// print('isBase64${data.isBase64}');  // Should print true
// print('contentAsBytes${data.contentAsBytes()}');  

              // Uint8List image = base64Decode(data.contentAsBytes().toString());
  // String imagenJson = "iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAAKYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIpQBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpdmZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoePPQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKcTNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jcW+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQjLYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=";
  Uint8List _image = base64Decode(displayNamereplaceAll);


    return Card(
        child: ListTile(
      title: nDataList1.owner.displayName == " "
          ? Text("Lable")
          : Text(nDataList1.post.page.name),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          nDataList1.post.coverImage != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.memory(_image)
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
          nDataList1.post.title == null
              ? Text(
                  "Lable",
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                )
              : Text(
                  "${nDataList1.post.title}",
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                ),
          nDataList1.post.detail == null
              ? Text(
                  "Lable",
                  overflow: TextOverflow.clip,
                  // style: TextStyle(color: Colors.black),
                  // maxLines: 2,
                )
              : Text(
                  "${nDataList1.post.detail}",
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
                        var postid = nDataList1.post.id;
                        print("postid${nDataList1.post.id}");
                        showCupertinoModalBottomSheet(
                          context: context,
                          builder: (context) => CommentList(
                            myuid: myuid,
                            postid: postid,
                          ),
                        );
                      }),
              Icon(Icons.repeat),
              Icon(Icons.favorite_border),
            ],
          ),
          Divider(
            height: 2,
          ),
        ],
      ),
      leading: CircleAvatar(
        child: Container(
          color: Colors.white,
          child: Image.network(
              "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image"),
        ),
      ),

      // backgroundImage: NetworkImage(
      //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
      // trailing: Icon(icons[index])
    ));
    // Container(
    //   child: Expanded(
    //       child: Padding(
    //     padding: EdgeInsets.all(8),
    //     child: Container(
    //       decoration: BoxDecoration(
    //           color: Colors.grey[200],
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(10),
    //           )),
    //       child: Expanded(
    //         child: Column(
    //           children: [
    //             //============TitleList===============
    //             Container(
    //               child: ListTile(
    //                 title: Text(
    //                   "${nDataList1.title}",
    //                   // maxLines:
    //                   //     1,
    //                   overflow: TextOverflow
    //                       .ellipsis, // TextOverflow.clip // TextOverflow.fade
    //                   // softWrap:
    //                   //     false,
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                     color: Color(0xffF47932),
    //                   ),
    //                 ),
    //                 trailing: Wrap(
    //                   spacing: 2, // space between two icons
    //                   children: <Widget>[
    //                     Container(
    //                       padding: EdgeInsets.fromLTRB(1, 6, 1, 1),
    //                       child: InkWell(
    //                         child: Text(
    //                           "${format.format(nDataList1.startDateTime)}",
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.red[500]),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //             //============TitleList===============
    //             //============SubTitleList===============

    //             Padding(
    //               padding: const EdgeInsets.symmetric(vertical: 8.0),
    //               child: Image.network(
    //                 'today-api.moveforwardparty.org/api${nDataList1.coverImage}/image',
    //               ),
    //               // imageUrl:'https://today-api.moveforwardparty.org/api${nDataList1.coverImage}/image'),
    //               // "https://today-api.moveforwardparty.org/api/${nDataList1.coverImage}/image"),
    //             ),
    //             // : const SizedBox.shrink(),
    //             Container(
    //               padding: EdgeInsets.all(10),
    //               child: Expanded(
    //                 child: Text(
    //                   "${nDataList1.detail}",
    //                   maxLines: 4,
    //                   softWrap: true,
    //                   style: TextStyle(
    //                     fontSize: 18,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Row(
    //               children: <Widget>[
    //                 Spacer(),
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: Text('0ความคิดเห็น'),
    //                 ),
    //                 SizedBox(
    //                   width: 2,
    //                 ),
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: Text('0ถูกใจ'),
    //                 ),
    //                 SizedBox(
    //                   width: 2,
    //                 ),
    //                 Align(
    //                   alignment: Alignment.topRight,
    //                   child: Text('0แชร์'),
    //                 ),
    //                 SizedBox(
    //                   width: 9,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   )),
    // );
  }
}
