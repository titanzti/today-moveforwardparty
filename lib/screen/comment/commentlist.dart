import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/commentlistmodel.dart';
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

    var url = "https://today-api.moveforwardparty.org/api/post/$postid/comment/$commentid";
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


  Widget _buildCommentList() {
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
                    child: const Text('Delete',style: TextStyle(color: Colors.red,)),
                    onPressed: () {
                       Navigator.pop(context);
                     showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text("Delete Comment",style: TextStyle(fontWeight: FontWeight.bold),),
            content: new Text("My alert message"),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,  child: new Text("Cancel"),onPressed: ()=> Navigator.pop(context),),
                  CupertinoDialogAction(
                  child: new Text("Delete",style: TextStyle(color: Colors.red),)
                  ,onPressed:  ()async{
deletecomment(widget.postid, mytoken, commentid, widget.myuid);
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
              child: Container(
                color: Colors.yellow,
                child: new ListTile(
                    leading: new CircleAvatar(
                      child: Container(
                        color: Colors.white,
                        child: Image.network(
                            "https://today-api.moveforwardparty.org/api${data.user.imageUrl}/image"),
                      ),
                    ),
                    title: new Text('${data.user.displayName}""'),
                    subtitle: new Text(
                      '${data.comment}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
              ),
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
            children: <Widget>[
              Container(
                child: Text(
                  'Comment',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Expanded(
                child:  _buildCommentList(),
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
                autofocus: true,
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
