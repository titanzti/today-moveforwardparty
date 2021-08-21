import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/commentlistmodel.dart';
import 'package:appmove/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as Http;

class CommentList extends StatefulWidget {
  final String myuid;
  final String postid;

  const CommentList({Key key, this.myuid, this.postid}) : super(key: key);
  // const CommentList({ Key? key }) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  var loading = false;
  var dataht;
  List<CommentlistModel> listModel = [];
  TextEditingController _commentController = TextEditingController();

  var jsonResponse, mytoken;
  Future getcommentlist;
  bool onref = false;
  StreamController _postsController;

  @override
  void didChangeDependencies() {
    setState(() {
      Api.getcommentlist(widget.postid, widget.myuid);
    });

    super.didChangeDependencies();
  }

  @override
  void initState() {
    setState(() {
      Api.gettoke().then((value) => ({
            setState(() {
              mytoken = value;
            }),
            print('myuidhome$mytoken'),
          }));

      getcommentlist = Api.getcommentlist(widget.postid, widget.myuid)
          .then((responseData) => ({
                setState(() {
                  loading = true;
                }),
                print('getHashtagData'),
                if (responseData.statusCode == 200)
                  {
                    dataht = jsonDecode(responseData.body),
                    print("comlist${dataht["data"]}"),
                    for (Map i in dataht["data"])
                      {
                        setState(() {
                          listModel.add(CommentlistModel.fromJson(i));
                          _postsController.add(responseData);
                        }),
                        print('listModel${listModel.length}'),
                      },
                    loading = false,
                  }
              }));
      _postsController = new StreamController();
    });

    super.initState();
  }

  Future sendcomment(
      String postid, String mytoken, String mag, String myuid) async {
    print('sendcomment');

    var url = "https://today-api.moveforwardparty.org/api/post/$postid/comment";
    final headers = {
      "userid": myuid,
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Bearer $mytoken",
    };
    Map data = {
      "commentAsPage": myuid,
      "comment": mag,
      //      "mediaURL": "",
      // "post": postid,
      // "user": "60c9cc216923656607919f06",
      // "likeCount": 0,
      // "deleted": false,
      // "id": "60f583d3ef898e1a0a05ed3d"
    };
    var body = jsonEncode(data);

    final responseData = await Http.post(
      url,
      headers: headers,
      body: body,
    );
    print('body$body');
    print('responseDatacommentlist${responseData.body}');
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      print(jsonResponse['status']);
      if (jsonResponse['status'] == 1) {
        setState(() {
          onref = true;
        });
      }
    }
  }

  Future deletecomment(
      String postid, String mytoken, String commentid, String myuid) async {
    print('sendcomment');

    var url =
        "https://today-api.moveforwardparty.org/api/post/$postid/comment/$commentid";
    final headers = {
      "userid": myuid,
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Bearer $mytoken",
    };

    final responseData = await Http.delete(
      url,
      headers: headers,
    );
    print('responseDatacommentlist${responseData.body}');
    final jsonResponse = jsonDecode(responseData.body);
    if (responseData.statusCode == 200) {
      print(jsonResponse['status']);
      if (jsonResponse['status'] == 1) {
        setState(() {
          onref = true;
        });
      }
      print("deletecomment สำเร็จ");
    }
  }

  Widget _buildCommentList(Size size) {
    return StreamBuilder(
      stream: _postsController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: listModel.length,
          itemBuilder: (BuildContext context, int index) {
            var data = listModel[index];
            var commentid = data.id;

            return new InkWell(
                onTap: () {
                  print("=>>>>>${data.id}");
                  showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                            // title: const Text('Title'),
                            // message: const Text('Message'),
                            actions: <CupertinoActionSheetAction>[
                              CupertinoActionSheetAction(
                                child: const Text('Edit'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                    )),
                                onPressed: () {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          new CupertinoAlertDialog(
                                            title: new Text(
                                              "Delete Comment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                           
                                            actions: [
                                              CupertinoDialogAction(
                                                isDefaultAction: true,
                                                child: new Text("Cancel"),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              CupertinoDialogAction(
                                                  child: new Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () async {
                                                    deletecomment(
                                                        widget.postid,
                                                        mytoken,
                                                        commentid,
                                                        widget.myuid);
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ));
                                },
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  // widget.data['toCommentID'] == null ? EdgeInsets.all(8.0) : EdgeInsets.fromLTRB(34.0,8.0,8.0,8.0),
                  child: Stack(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(6.0, 2.0, 10.0, 2.0),
                            child: Container(
                              width: 48,
                              // widget.data['toCommentID'] == null ? 48 : 40,
                              height: 48,
                              // widget.data['toCommentID'] == null ? 48 : 40,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image",
                                placeholder: (context, url) =>
                                    new CupertinoActivityIndicator(),
                                errorWidget: (context, url, error) =>
                                    new Image.asset('images/persoud11.jpg'),
                              ),

                              // Image.network(
                              //         "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image"),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          data.user.displayName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 4.0),
                                        child: Text(
                                          data.comment,
                                          maxLines: null,
                                        ),
                                        // widget.data['toCommentID'] == null ? Text(widget.data['commentContent'],maxLines: null,) :
                                        // RichText(
                                        //   text: TextSpan(
                                        //     children: <TextSpan>[
                                        //       TextSpan(text: widget.data['toUserID'], style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue[800])),
                                        //       TextSpan(text: Utils.commentWithoutReplyUser(widget.data['commentContent']), style: TextStyle(color:Colors.black)),
                                        //     ],
                                        //   ),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                                width: size.width - 90,
                                // widget.size.width- (widget.data['toCommentID'] == null ? 90 : 110),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 4.0),
                                child: Container(
                                  width: size.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(Utils.readTimestamp(data
                                          .createdDate.millisecondsSinceEpoch)),
                                      GestureDetector(
                                        // onTap: () => _updateLikeCount(_currentMyData.myLikeCommnetList != null && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? true : false),
                                        child: Text(
                                          'Like',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[700]),

                                          // style:TextStyle(fontWeight: FontWeight.bold,color:_currentMyData.myLikeCommnetList != null && _currentMyData.myLikeCommnetList.contains(widget.data['commentID']) ? Colors.blue[900] : Colors.grey[700])
                                        ),
                                      ),
//                                       GestureDetector(
//                                           onTap: () {
//                                             // widget.replyComment([widget.data['userName'],widget.data['commentID'],widget.data['FCMToken']]);
// //                                _replyComment(widget.data['userName'],widget.data['commentID'],widget.data['FCMToken']);
//                                             print('leave comment of commnet');
//                                           },
//                                           child: Text('Reply',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.grey[700]))),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // widget.data['commentLikeCount'] > 0 ? Positioned(
                      //   bottom: 10,
                      //   right:0,
                      //   child: Card(
                      //       elevation:2.0,
                      //       child: Padding(
                      //         padding: const EdgeInsets.all(2.0),
                      //         child: Row(
                      //           children: <Widget>[
                      //             Icon(Icons.thumb_up,size: 14,color: Colors.blue[900],),
                      //             Text('${widget.data['commentLikeCount']}',style:TextStyle(fontSize: 14)),
                      //           ],
                      //         ),
                      //       )
                      //   ),
                      // ) : Container(),
                    ],
                  ),
                )
                // Container(
                //   color: Colors.yellow,
                //   child: new ListTile(
                //                             contentPadding: EdgeInsets.all(12),

                //       leading: new CircleAvatar(
                //         child: Container(
                //           color: Colors.white,
                //           child: Image.network(
                //               "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image"),
                //         ),
                //       ),
                //       title: new Text('${data.user.displayName}""'),
                //       subtitle: new Text(
                //         '${data.comment}',
                //         style: TextStyle(fontSize: 16, color: Colors.black),
                //       ),
                //     ),
                // ),
                );
          },
        );
      },
    );

    // FutureBuilder(
    //   future: getcommentlist,
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     return
    //   },
    // );
  }

  Future<Null> _handleRefresh() async {
    new Future.delayed(const Duration(seconds: 2));
    setState(() {
      listModel.clear();
    });
    Api.getcommentlist(widget.postid, widget.myuid).then((responseData) => ({
          setState(() {
            loading = true;
          }),
          print('getHashtagData'),
          if (responseData.statusCode == 200)
            {
              dataht = jsonDecode(responseData.body),
              print("comlist${dataht["data"]}"),
              for (Map i in dataht["data"])
                {
                  setState(() {
                    listModel.add(CommentlistModel.fromJson(i));
                    _postsController.add(responseData);
                  }),
                  print('listModel${listModel.length}'),
                },
              setState(() {
                loading = false;
                onref = false;
              }),
            }
        }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (onref == true) {
      _handleRefresh();
    }
    print(onref);

    return Container(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => () async {
            print('RefreshIndicator');
            HapticFeedback.mediumImpact();

            _handleRefresh();
          }(),
          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Comment',
                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: _buildCommentList(size),
              ),
              TextFormField(
                controller: _commentController,
                onFieldSubmitted: (String msg) async {
                  //  await  Api.sendcomment(widget.postid);
                  //  .then((value) => ({

                  //     if(value.statusCode==200){
                  //   jsonResponse = jsonDecode(value.body),

                  //               print("message${jsonResponse['message']}"),

                  //     }

                  //   }));
                },
                // autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20.0),
                  hintText: "Add comment ",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.black,
                    ),
                    onPressed: () async {
                      // print("sendcomment");
                      print("${widget.postid}");

                      // setState(() {
                      //   onref = true;
                      // });
                      await sendcomment(widget.postid, mytoken,
                          _commentController.text, widget.myuid);

                      setState(() {
                        _commentController.clear();
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
