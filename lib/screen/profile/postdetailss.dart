import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/model/postdetailss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:image/image.dart' as ImageProcess;

class PostDetailSSScreen extends StatefulWidget {
  final String htmlData;
  final String id;
  final String image;

  const PostDetailSSScreen({Key key, this.htmlData, this.id, this.image})
      : super(key: key);

  @override
  _PostDetailSSScreenState createState() => _PostDetailSSScreenState();
}

class _PostDetailSSScreenState extends State<PostDetailSSScreen> {
  Future getPostss;
  var dataht;
  var storytest, storyimage;

  List<PostDetailSSModel> listdeatilss = [];
  String story1;
  String base64Image;
  var storytestreplaceAll;
  Widget image;

  Future getProfileSS(String id) async {
    print('getProfileSS');
    try {
      var url = "https://today-api.moveforwardparty.org/api/post/search";
      final headers = {
        "content-type": "application/json",
      };
      Map data = {
        "limit": 10,
        "count": false,
        "whereConditions": {"_id": id}
      };
      var body = jsonEncode(data);

      var responseRequest = await http.post(url, headers: headers, body: body);

      if (responseRequest.statusCode == 200) {
        final jsonResponse = jsonDecode(responseRequest.body);
        setState(() {
          var date1 = jsonResponse["data"];

          for (var i in date1) {
            storytest = i["story"]["story"];
            storyimage = i["story"]["coverImage"];

            storytestreplaceAll = storytest.replaceAll("<create-text>", "");

            print('storytest${storytest}');
            // print(i);
          }
        });
        List<int> imageBytes = storyimage.readAsBytesSync();
        base64Image = base64Encode(imageBytes);
        // print('base64Image$base64Image');

        final _byteImage = Base64Decoder().convert(base64Image);
        image = Image.memory(_byteImage);
        print('imageBase64Decoder$image');

        print("Response status :${jsonResponse.statusCode}");
      }

      // return responsepostRequest;
    } catch (e) {}
  }

  @override
  void initState() {
    getProfileSS(widget.id);

    // Api.getPostDetailSS(widget.id).then((responseData) => ({
    //       // setState(() {
    //       //   loading = true;
    //       // }),
    //       print('getPostListSS'),
    //       if (responseData.statusCode == 200)
    //         {
    //           dataht = jsonDecode(responseData.body),
    //           print(dataht),
    //           print(story1),

    //           for (var i in dataht["data"])
    //             {
    //               // i["story"] = '',
    //               // story1 = dataht["data"]["story"][0],
    //               // print(dataht["data"]["story"]["story"]),
    //               print('story${story1 = i["story"]}'),

    //               // listdeatilss.add(),
    //               // story = dataht["data"]["story"]["story"],
    //               // print('story$story'),
    //               print(listdeatilss.length)
    //             },

    //           // loading = false,
    //         }
    //     }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF47932),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Detail",
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
        child: storytestreplaceAll == null
            ? Center(
                child: Center(child: Text("Loading...")),
              )
            : Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                        width: 300,
                        height: 100,
                        child: new Image.asset('images/placeholder.png')),
                    Html(
                      data: """
                  ${storytestreplaceAll == null ? CupertinoActivityIndicator() : storytestreplaceAll}
                  """,
                      // padding: EdgeInsets.all(8.0),
                      onLinkTap: (url) {
                        print("Opening $url...");
                      },
                      customRender: (node, children) {
                        if (node is dom.Element) {
                          switch (node.localName) {
                            case "custom_tag": // using this, you can handle custom tags in your HTML
                              return Column(children: children);
                          }
                        }
                      },
                    ),
                    // Text('data'),
                  ],
                ),
              ),
        //  Text("$storytest"),
      ),
    );
  }
}
