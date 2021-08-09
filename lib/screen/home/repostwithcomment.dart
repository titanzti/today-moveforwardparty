import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RepostWithComSc extends StatefulWidget {
  // const RepostWithComSc({ Key? key }) : super(key: key);

  @override
  _RepostWithComScState createState() => _RepostWithComScState();
}

class _RepostWithComScState extends State<RepostWithComSc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: Text('data'),

           title: Text("App Bar without Back Button"),
  automaticallyImplyLeading: false,
          actions: [

          ],
        ),
        body:  Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetAvatar(),
          tweetBody(),
        ],
      ),
    ),
        
      ),
      
    );
  }
  
  Widget tweetAvatar() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: CircleAvatar(
        backgroundImage: NetworkImage("this.avatar"),
      ),
    );
  }

  Widget tweetBody() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tweetHeader(),
          tweetText(),
          tweetButtons(),
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
          tweetIconButton(FontAwesomeIcons.comment," this.comments"),
          tweetIconButton(FontAwesomeIcons.retweet," this.retweets"),
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