import 'dart:convert';

import 'package:appmove/api/Api.dart';
import 'package:appmove/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RepostWithComSc extends StatefulWidget {
  final String postpagename;
  final String postcoverImage;
  final String posttitle;
  final String postdetail;
  final String postid;
  final String ownerimageUrl;
  final DateTime createdDate;
  final String postpagepageUsername;
  final String myuid;
  final String token;

  const RepostWithComSc(
      {Key key,
      this.postpagename,
      this.postcoverImage,
      this.posttitle,
      this.postdetail,
      this.postid,
      this.ownerimageUrl,
      this.createdDate,
      this.postpagepageUsername,
      this.myuid,
      this.token})
      : super(key: key);

  // const RepostWithComSc({ Key? key }) : super(key: key);

  @override
  _RepostWithComScState createState() => _RepostWithComScState();
}

class _RepostWithComScState extends State<RepostWithComSc> {
  var imageURL;
  TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Api.getimageURL().then((value) => ({
          setState(() {
            imageURL = value;
          }),
          print('getimageURL$imageURL'),
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF47932),
      child: Scaffold(
        backgroundColor: Color(0xffF47932),
        appBar: AppBar(
          backgroundColor: Color(0xffF47932),

          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          // title: Text("App Bar without Back Button"),
          automaticallyImplyLeading: false,
          actions: [
            Container(
              // height: 10,
              // width: 100,
              decoration: BoxDecoration(
                color: Color(0xff0C3455),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TextButton(
                  onPressed: () async {
                    var jsonResponse;
                    var status;

                    await Api.repostwithdetail(widget.postid, widget.myuid,
                            widget.token, _detailController.text)
                        .then((response) => ({
                              jsonResponse = jsonDecode(response.body),
                              if (response.statusCode == 200)
                                {
                                  status = jsonResponse["status"],
                                  print(status),
                                  if (status == 1)
                                    {
                                      setState(() {
                                        // isshow = true;
                                        _detailController.clear();
                                                      Navigator.of(context).pop();

                                      }),
                                    }
                                }
                            }));
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            //     IconButton(
            //   icon: Icon(
            //     Icons.close,
            //     color: Colors.black,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tweetAvatar(),
                    tweetBody(),
                  ],
                ),
                _buildTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    final maxLines = 5;

    return Container(
      padding: EdgeInsets.only(left: 40),
      margin: EdgeInsets.all(12),
      // height: maxLines * 24.0,
      child: PostList(
        widget.postpagename,
        widget.postcoverImage,
        widget.posttitle,
        widget.postdetail,
        widget.postid,
        widget.ownerimageUrl,
        widget.createdDate,
        widget.postpagepageUsername,
      ),
    );
  }

  Widget PostList(
    String postpagename,
    String postcoverImage,
    String posttitle,
    String postdetail,
    String postid,
    String ownerimageUrl,
    DateTime createdDate,
    String postpagepageUsername,
  ) {
    return InkWell(
      onTap: () {},
      child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(postpagename,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('$postpagepageUsername',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                        Utils.readTimestamp(createdDate.millisecondsSinceEpoch),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ],
            ),
            subtitle: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
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
                      ),
                postcoverImage != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.network(
                          "https://today-api.moveforwardparty.org/api$postcoverImage/",
                          width: 250,
                          height: 200,
                          filterQuality: FilterQuality.medium,
                        ),
                      )
                    : const SizedBox.shrink(),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 2,
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://today-api.moveforwardparty.org/api$ownerimageUrl/image"),
              radius: 20,
            ),
          )),
    );
  }

  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://today-api.moveforwardparty.org/api$imageURL/image"),
      ),
    );
  }

  Widget tweetBody() {
    final maxLines = 5;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _detailController,
            autofocus: true,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: "Enter a message",
              fillColor: Colors.white,
              filled: true,
            ),
          ),
          // tweetText(),
          // tweetButtons(),
        ],
      ),
    );
  }

  Widget tweetHeader() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: Text(
            "this.username",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '@"name" · "timeAgo"',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.angleDown,
            size: 14.0,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget tweetText() {
    return Text(
      "text",
      overflow: TextOverflow.clip,
    );
  }

  Widget tweetButtons() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          tweetIconButton(FontAwesomeIcons.comment, " this.comments"),
          tweetIconButton(FontAwesomeIcons.retweet, " this.retweets"),
          tweetIconButton(FontAwesomeIcons.heart, "this.favorites"),
          tweetIconButton(FontAwesomeIcons.share, ''),
        ],
      ),
    );
  }

  Widget tweetIconButton(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.0,
          color: Colors.black45,
        ),
        Container(
          margin: const EdgeInsets.all(6.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
