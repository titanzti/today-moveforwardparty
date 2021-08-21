import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/model/searchpostlist.dart';
import 'package:appmove/screen/comment/commentlist.dart';
import 'package:appmove/screen/home/repostwithcomment.dart';
import 'package:appmove/screen/loginandregister/Intro.dart';
import 'package:appmove/screen/profile/postdetailss.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchList extends StatefulWidget {
  final String label;
  final String type;

  const SearchList({Key key, this.label, this.type}) : super(key: key);

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  List<SearchPostList> listSearchPostList = [];
  var loading = false;
  var dataht, myuid;
  Future getsearchlist;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 5;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var checktoken;

  @override
  void initState() {
    setState(() {
      Api.getmyuid().then((value) => ({
            setState(() {
              myuid = value;
            }),
            print('myuidhome$myuid'),
          }));
              Api.gettoke().then((value) => value({
                          checktoken = value,
                          print('checktokenSearchList$checktoken'),
                        }));
    });
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('At the End');
        Text('loading');
        setState(() {
          _currentMax = _currentMax + 5;
       if (widget.type == "TAG") {
      var storytestreplaceAll = widget.label.replaceAll("#", "");
      print('storytestreplaceAll$storytestreplaceAll');
      getsearchlist =
          Api.apisearchlist("", storytestreplaceAll,_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }


    
    if (widget.type == "Null") {
      getsearchlist =
          Api.apisearchlist(widget.label, "",_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }

    if (widget.type == "HASHTAG") {
      var storytestreplaceAll = widget.label.replaceAll("#", "");
      print('storytestreplaceAll$storytestreplaceAll');
      getsearchlist =
          Api.apisearchlist("", storytestreplaceAll,_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }
    

    if (widget.type == "PAGE") {
      print('PAGE');
      getsearchlist =
          Api.apisearchlist(widget.label, "",_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }
        });
      }
    });
       if (widget.type == "TAG") {
      var storytestreplaceAll = widget.label.replaceAll("#", "");
      print('storytestreplaceAll$storytestreplaceAll');
      getsearchlist =
          Api.apisearchlist("", storytestreplaceAll,_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }


    
    if (widget.type == "Null") {
      getsearchlist =
          Api.apisearchlist(widget.label, "",_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }

    if (widget.type == "HASHTAG") {
      var storytestreplaceAll = widget.label.replaceAll("#", "");
      print('storytestreplaceAll$storytestreplaceAll');
      getsearchlist =
          Api.apisearchlist("", storytestreplaceAll,_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }
    

    if (widget.type == "PAGE") {
      print('PAGE');
      getsearchlist =
          Api.apisearchlist(widget.label, "",_currentMax).then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    for (Map i in dataht["data"])
                      {
                        print('testsc$i'),
                        listSearchPostList.add(SearchPostList.fromJson(i)),
                      },
                    setState(() {
                      loading = false;
                    }),
                  }
              }));
    }

    super.initState();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF47932),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Color(0xffF47932),
            title: Text('${widget.label}'),
          ),
          body: SingleChildScrollView(
                controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      loading == true ? Text('${widget.label}') : Container(),
                      FutureBuilder(
                        future: Future.wait([
                          getsearchlist,
                        ]),
                        //  initialData: InitialData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CupertinoActivityIndicator());
                          }
                          return ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: listSearchPostList.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == listSearchPostList.length) {
                                      return CupertinoActivityIndicator();
                                    }
                                    
                              if (listSearchPostList.length == 0) {
                                return Center(
                                    child: CupertinoActivityIndicator());
                              }
                              var nDataList1 = listSearchPostList[index];

                              return PostList(nDataList1);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
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
                          title: Text('บอกต่อเรื่องราว'),
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
                          title: Text('บอกต่อเรื่องราวพร้อมความคิดเห็น'),
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
                      ],
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        },
                        child: ListTile(
                          title: Center(child: Text('ยกเลิก')),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Widget PostList(SearchPostList nDataList1) {
    // var displayNamereplaceAll;
    // var displayname = nDataList1.owner.displayName.toString();
    // displayNamereplaceAll = displayname.replaceAll("DisplayName.", "");
    var base64String =
        "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image";
    var postid = nDataList1.post.id;
    print('postid$postid');

    return InkWell(
      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PostDetailSSScreen(
                    id: nDataList1.post.id,
                  )),
        );
      },
    
      child: Card(
        child: ListTile(
          title: nDataList1.page.name == " "
              ? Text("Lable")
              : Text(nDataList1.page.name),
          subtitle: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              nDataList1.post.coverImage != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image",
                        placeholder: (context, url) =>
                            new CupertinoActivityIndicator(),
                        errorWidget: (context, url, error) =>
                            new Image.asset('images/placeholder.png'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 Text(nDataList1.post.commentCount.toString()),
                checktoken == ""
                    ? IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    : IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          HapticFeedback.lightImpact();

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
                Text(nDataList1.post.shareCount.toString()),
                checktoken == ""
                    ? IconButton(
                        icon: Icon(Icons.repeat),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    : IconButton(
                        icon: Icon(Icons.repeat),
                        onPressed: () async {
                          HapticFeedback.lightImpact();

                          _showSettingsPanel(
                            postid,
                            nDataList1.page.name,
                           nDataList1.post.coverImage,
                            nDataList1.post.title,
                            nDataList1.post.detail,
                            nDataList1.user.imageUrl,
                            nDataList1.post.createdDate,
                            nDataList1.page.pageUsername,
                          );

                          print("กดlike");
                        }),
                Spacer(),
                Text(nDataList1.post.likeCount.toString()),
                checktoken == ""
                    ? IconButton(
                        icon: Icon(FontAwesome.heart_o),
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          showCupertinoModalBottomSheet(
                            context: context,
                            builder: (context) => Intro(),
                          );
                        })
                    : IconButton(
                        icon: Icon(FontAwesome.heart_o),
                        onPressed: () async {
                          HapticFeedback.lightImpact();

                          var jsonResponse;
                          await Api.islike(postid, "60c9cc216923656607919f06", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwYzljYzIxNjkyMzY1NjYwNzkxOWYwNiIsImlhdCI6MTYyOTI2ODc3M30.hA7eZDgwbgd0v7eHIbHXuZnYLnkiOXTDxeP_orHUnXQ")
                              .then((value) => ({
                                    jsonResponse = jsonDecode(value.body),
                                    print('message${jsonResponse['message']}'),
                                    if (value.statusCode == 200)
                                      {
                                        if (jsonResponse['message'] ==
                                            "Like Post Success")
                                          {
                                            setState(() {
                                              nDataList1.post.likeCount++;
                                            }),
                                          }
                                        else if (jsonResponse['message'] ==
                                            "UnLike Post Success")
                                          {
                                            setState(() {
                                              nDataList1.post.likeCount--;
                                            }),
                                          }
                                      }
                                  }));
                          print("กดlike");
                        }),
                ],
              )
            ],
          ),
          leading: CircleAvatar(
            radius: 20,
            child: Container(
              color: Colors.white,
              child: Image.network(
                  "https://today-api.moveforwardparty.org/api${nDataList1.page.imageUrl}/image"),
            ),
          ),
          //
          // backgroundImage: NetworkImage(
          //     "https://today-api.moveforwardparty.org/api${nDataList1.owner.imageUrl}/image")),
          // trailing: Icon(icons[index])
        ),
      ),
    );
  }
}
