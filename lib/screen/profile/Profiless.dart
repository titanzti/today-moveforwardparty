import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postlistSSmodel.dart';
import 'package:appmove/screen/comment/commentlist.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/profile/postdetailss.dart';
import 'package:appmove/utils/internetConnectivity.dart';
import 'package:appmove/widgets/allWidgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as Http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ProfilessScreen extends StatefulWidget {
  final String id;
  final String image;
  final String name;

  const ProfilessScreen({Key key, this.id, this.image, this.name})
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
  var checktoken,myuid;

  bool isLoading = false;
  var story;

  int page = 5;
  List<PostListSS> data = List();
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  setState(() {
                     Api.gettoke().then((value) => value({
                          checktoken = value,
                        }));
                          Api.getmyuid().then((value) => ({
                         setState(() {
                        myuid = value;
                              }),
                        print('myuidhome$myuid'),

                     }));
                    // scrollController = ScrollController();
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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
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
          // widget.istoken == ""
          //     ? Container()
          //     : InkWell(
          //         onTap: () async {
          //           showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return SimpleDialog(
          //                   title: Text('logout?🤷🏻‍♂️'),
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
          //                       child: Text('Yes👌🏻'),
          //                     ),
          //                     // SimpleDialogOption(
          //                     //   onPressed: handleImageSelecting,
          //                     //   child: Text('select a pic'),
          //                     // ),
          //                     SimpleDialogOption(
          //                       child: Text('cancel🙅🏻‍♂️'),
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
                                image: NetworkImage(
                                    "https://today-api.moveforwardparty.org/api${widget.image}/image"),
                                fit: BoxFit.cover)),
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
                    padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                    child: widget.name == null
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
                //               "แก้ไขโปรไฟล์",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //       ),
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
                            return Text("ไม่มีข้อมูล");
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
                                    
                                    if(listpostss.length==0){
                                      return Center(child: Text("ไม่มีข้อมูล"));
                                    }
                                    final nDataList1 = listpostss[index];

                                    // nDataList1.story.story != "" ?print('มีstory'):print("ไม่มี");

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
                  )),
        );
        print('กด');
      },
      child: Card(
          child: ListTile(
        title: Text("${widget.name}"),
        subtitle: Column(
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            nDataList1.coverImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                      child: CachedNetworkImage(
                        
                        imageUrl:
                            "https://today-api.moveforwardparty.org/api${nDataList1.coverImage}/image",
                        placeholder: (context, url) =>
                            new CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            Container(
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
                checktoken  ==""?IconButton(icon: Icon(Icons.comment), 
              onPressed: (){
                   showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );

 
              }):  IconButton(icon: Icon(Icons.comment), 
              onPressed: (){
                print("กด");
                var postid =nDataList1.id;
                print("postid${nDataList1.id}");
                 showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => CommentList(myuid: myuid,postid: postid,),
                          );

 
              }),
                Icon(Icons.repeat),
                Icon(Icons.favorite_border),
              ],
            )
          ],
        ),
        leading: CircleAvatar(
          child: Container(
            color: Colors.white,
            child: Image.network(
                "https://today-api.moveforwardparty.org/api${widget.image}/image"),
          ),
        ),
        // trailing: Icon(icons[index])
      )),
    );
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
