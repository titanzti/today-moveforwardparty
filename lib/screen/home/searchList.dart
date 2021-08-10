import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postModel.dart';
import 'package:appmove/model/searchpostlist.dart';
import 'package:appmove/screen/comment/commentlist.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    setState(() {
      Api.getmyuid().then((value) => ({
            setState(() {
              myuid = value;
            }),
            print('myuidhome$myuid'),
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

  Widget PostList(nDataList1) {
    // var displayNamereplaceAll;
    // var displayname = nDataList1.owner.displayName.toString();
    // displayNamereplaceAll = displayname.replaceAll("DisplayName.", "");
    var base64String =
        "https://today-api.moveforwardparty.org/api${nDataList1.post.coverImage.toString()}/image";
    var postid = nDataList1.post.id;

    return InkWell(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) => CommentList(
            myuid: myuid,
            postid: postid,
          ),
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
                  Icon(Icons.comment),
                  Icon(Icons.repeat),
                  Icon(Icons.favorite_border),
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
